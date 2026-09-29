import * as vscode from 'vscode';
import * as path from 'path';
import { parseDiffLocation } from './diffParser';
import { parseCodePathPrefix } from './codePathParser';

// There's no VS Code extension API to get the remote home directory from a UI
// extension (`os.homedir()` returns the local home dir, not the remote). We
// parse it from the file path instead, so the extension can run as a UI
// extension without needing to be installed on remote servers.
function getHomeDir(filePath: string): string | null {
	let match = filePath.match(/^(\/home\/[^/]+)/);
	if (match) return match[1];
	match = filePath.match(/^(\/Users\/[^/]+)/);
	if (match) return match[1];
	if (filePath.startsWith('/root/')) return '/root';
	return null;
}

// Preserves the scheme and authority of `uri`, so paths on remote hosts stay
// remote instead of collapsing to a local `file:` URI.
function parentUri(uri: vscode.Uri): vscode.Uri {
	return uri.with({ path: path.dirname(uri.path) });
}

export function activate(context: vscode.ExtensionContext) {
	const openDirectory = async (uri: vscode.Uri | undefined, forceNewWindow: boolean) => {
		// `vscode.workspace.fs` instead of Node's `fs`, so directories on
		// remote hosts resolve through VS Code's file system providers
		const resourceUri = uri ?? vscode.window.activeTextEditor?.document.uri;
		if (!resourceUri) {
			return;
		}
		let dirUri: vscode.Uri;
		try {
			const stat = await vscode.workspace.fs.stat(resourceUri);
			const isDirectory = (stat.type & vscode.FileType.Directory) !== 0;
			dirUri = isDirectory ? resourceUri : parentUri(resourceUri);
		} catch {
			return;
		}
		await vscode.commands.executeCommand('vscode.openFolder', dirUri, { forceNewWindow });
	};
	let openDirectoryDisposable = vscode.commands.registerCommand('robenkleene.openDirectory', (uri?: vscode.Uri) => {
		return openDirectory(uri, false);
	});
	context.subscriptions.push(openDirectoryDisposable);
	let openDirectoryInNewWindowDisposable = vscode.commands.registerCommand(
		'robenkleene.openDirectoryInNewWindow',
		(uri?: vscode.Uri) => openDirectory(uri, true)
	);
	context.subscriptions.push(openDirectoryInNewWindowDisposable);

	let selectParagraphDisposable = vscode.commands.registerCommand('robenkleene.selectParagraph', () => {
		const editor = vscode.window.activeTextEditor;
		if (!editor) {
			return;
		}
		const document = editor.document;
		// Whitespace-only lines count as blank, matching `cursorMove`'s blank line motions
		const isBlank = (line: number) => document.lineAt(line).isEmptyOrWhitespace;

		// From a blank line, take the paragraph below, like Emacs `mark-paragraph`
		let line = editor.selection.active.line;
		while (line < document.lineCount && isBlank(line)) {
			line++;
		}
		if (line >= document.lineCount) {
			return;
		}

		let firstLine = line;
		while (firstLine > 0 && !isBlank(firstLine - 1)) {
			firstLine--;
		}
		let lastLine = line;
		while (lastLine + 1 < document.lineCount && !isBlank(lastLine + 1)) {
			lastLine++;
		}

		// End on the next line so the trailing newline is included, except at the
		// end of the document where there isn't one
		const end = lastLine + 1 < document.lineCount
			? new vscode.Position(lastLine + 1, 0)
			: document.lineAt(lastLine).range.end;
		editor.selection = new vscode.Selection(new vscode.Position(firstLine, 0), end);
		editor.revealRange(new vscode.Range(end, end));
	});
	context.subscriptions.push(selectParagraphDisposable);

	let disposable = vscode.commands.registerCommand('robenkleene.copyGrep', () => {
		const editor = vscode.window.activeTextEditor;
		if (!editor) {
			return;
		}
		const document = editor.document;
		const selection = editor.selection;
		const line = selection.active.line + 1;
		const column = selection.active.character + 1;
		let filePath = document.uri.fsPath;
		const homeDir = getHomeDir(filePath);
		if (homeDir) {
			filePath = `~${filePath.substring(homeDir.length)}`;
		}
		const location = `${filePath}:${line}:${column}`;

		let result = location;
		if (selection) {
			const text = editor.document.getText(selection);
			if (text.length) {
				result += `:\n${text}`;
			}
		}

		vscode.env.clipboard.writeText(result).then(() => {
		  vscode.window.showInformationMessage(`${result}`);
		});
	});
	context.subscriptions.push(disposable);

	let copyGrepMarkdownDisposable = vscode.commands.registerCommand('robenkleene.copyGrepMarkdown', () => {
		const editor = vscode.window.activeTextEditor;
		if (!editor) {
			return;
		}
		const document = editor.document;
		const selection = editor.selection;
		const line = selection.active.line + 1;
		const column = selection.active.character + 1;
		let filePath = document.uri.fsPath;
		const homeDir = getHomeDir(filePath);
		if (homeDir) {
			filePath = `~${filePath.substring(homeDir.length)}`;
		}
		const location = `${filePath}:${line}:${column}:`;

		let result: string;
		if (selection && !selection.isEmpty) {
			const text = document.getText(selection);
			const lang = document.languageId;
			result = `\`\`\` grep\n${location}\n\`\`\`\n\n\`\`\` ${lang}\n${text}\n\`\`\``;
		} else {
			result = location;
		}

		vscode.env.clipboard.writeText(result).then(() => {
			vscode.window.showInformationMessage(`${result}`);
		});
	});
	context.subscriptions.push(copyGrepMarkdownDisposable);

	function resolveDiffUri(document: vscode.TextDocument, filePath: string): vscode.Uri {
		const workspaceFolder = vscode.workspace.workspaceFolders?.[0];
		if (workspaceFolder) {
			return vscode.Uri.joinPath(workspaceFolder.uri, filePath);
		}
		const dirUri = parentUri(document.uri);
		return vscode.Uri.joinPath(dirUri, filePath);
	}

	const diffDefinitionProvider = vscode.languages.registerDefinitionProvider(
		{ language: 'diff' },
		{
			provideDefinition(document, position) {
				const result = parseDiffLocation(document.getText(), position.line);
				if (!result) {
					return null;
				}
				const uri = resolveDiffUri(document, result.filePath);
				const targetLine = result.line - 1;
				const targetCol = Math.max(position.character - 1, 0);
				const targetPos = new vscode.Position(targetLine, targetCol);
				return new vscode.Location(uri, targetPos);
			}
		}
	);
	context.subscriptions.push(diffDefinitionProvider);

	let diffGotoSourceDisposable = vscode.commands.registerCommand('robenkleene.diffGotoSource', async () => {
		const editor = vscode.window.activeTextEditor;
		if (!editor) {
			return;
		}

		const document = editor.document;
		const cursorLine = editor.selection.active.line;
		const cursorCol = editor.selection.active.character;

		const result = parseDiffLocation(document.getText(), cursorLine);
		if (!result) {
			vscode.window.showInformationMessage('No source location found at cursor position');
			return;
		}

		const uri = resolveDiffUri(document, result.filePath);
		try {
			const targetDoc = await vscode.workspace.openTextDocument(uri);
			const targetLine = result.line - 1;
			const targetCol = Math.max(cursorCol - 1, 0);
			const pos = new vscode.Position(targetLine, targetCol);
			await vscode.window.showTextDocument(targetDoc, { selection: new vscode.Range(pos, pos) });
		} catch {
			vscode.window.showErrorMessage(`Could not open file: ${uri.toString()}`);
		}
	});
	context.subscriptions.push(diffGotoSourceDisposable);

	// Resolves the directory part of a typed path: `~/` from the home directory
	// in the document's path, `/` from the root, and anything else from the
	// document's directory, like Markdown's `[](...)` path completion
	function resolveCompletionDir(document: vscode.TextDocument, dir: string): vscode.Uri | null {
		const documentPath = document.uri.path;
		if (dir.startsWith('~/')) {
			const homeDir = getHomeDir(documentPath);
			if (!homeDir) {
				return null;
			}
			return document.uri.with({ path: path.posix.join(homeDir, dir.substring(2)) });
		}
		if (dir.startsWith('/')) {
			return document.uri.with({ path: dir });
		}
		// `untitled:` documents don't have a directory, use the workspace instead
		const baseUri = document.isUntitled
			? vscode.workspace.workspaceFolders?.[0]?.uri
			: parentUri(document.uri);
		if (!baseUri) {
			return null;
		}
		return vscode.Uri.joinPath(baseUri, dir);
	}

	// File name completion inside `` ` `` code spans and fenced code blocks.
	// Uses `vscode.workspace.fs` so it lists remote directories while still
	// running as a UI extension.
	const codePathCompletionProvider = vscode.languages.registerCompletionItemProvider(
		{ language: 'markdown' },
		{
			async provideCompletionItems(document, position) {
				const prefix = parseCodePathPrefix(document.getText(), position.line, position.character);
				if (!prefix) {
					return null;
				}
				const dirUri = resolveCompletionDir(document, prefix.dir);
				if (!dirUri) {
					return null;
				}
				let entries: [string, vscode.FileType][];
				try {
					entries = await vscode.workspace.fs.readDirectory(dirUri);
				} catch {
					return null;
				}
				const range = new vscode.Range(
					position.translate(0, -prefix.partial.length),
					position
				);
				return entries.map(([name, type]) => {
					const isDirectory = (type & vscode.FileType.Directory) !== 0;
					const item = new vscode.CompletionItem(
						name,
						isDirectory ? vscode.CompletionItemKind.Folder : vscode.CompletionItemKind.File
					);
					item.range = range;
					// Sort directories first
					item.sortText = `${isDirectory ? 0 : 1}${name}`;
					if (isDirectory) {
						item.insertText = `${name}/`;
						// Re-open suggestions to keep completing inside the directory
						item.command = { command: 'editor.action.triggerSuggest', title: '' };
					}
					return item;
				});
			}
		},
		'`', '/'
	);
	context.subscriptions.push(codePathCompletionProvider);

}

// This method is called when your extension is deactivated
export function deactivate() { }
