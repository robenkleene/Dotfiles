import * as vscode from 'vscode';
import * as path from 'path';
import { parseDiffLocation } from './diffParser';

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

// A fenced code block is delimited by a line starting with ```. The `^\s*`
// allows for a fence indented in a list, and the open fence's info string
// (e.g. ```sh) is ignored.
function isFenceLine(line: string): boolean {
	return /^\s*```/.test(line);
}

// The cursor is inside a fenced code block when an odd number of fence lines
// precede its line
function isInFencedCodeBlock(document: vscode.TextDocument, line: number): boolean {
	let fences = 0;
	for (let i = 0; i < line; i++) {
		if (isFenceLine(document.lineAt(i).text)) {
			fences++;
		}
	}
	return fences % 2 === 1;
}

// The cursor is inside an inline code span when an odd number of `` ` ``
// delimiters precede it on the line
function isInInlineCode(linePrefix: string): boolean {
	return (linePrefix.match(/`/g)?.length ?? 0) % 2 === 1;
}

// Resolve the directory a path completion prefix refers to. `~/` uses the
// document's own home directory (see `getHomeDir`) so remote documents resolve
// remotely, and `document.uri.with({ path })` keeps the document's scheme so
// `vscode.workspace.fs` reads from the right filesystem.
function resolvePathCompletionDir(document: vscode.TextDocument, dirPrefix: string): vscode.Uri | undefined {
	if (dirPrefix.startsWith('~/')) {
		const homeDir = getHomeDir(document.uri.fsPath);
		if (!homeDir) {
			return undefined;
		}
		return vscode.Uri.joinPath(document.uri.with({ path: homeDir }), dirPrefix.substring(2));
	}
	if (dirPrefix.startsWith('/')) {
		return document.uri.with({ path: dirPrefix });
	}
	const parentUri = document.uri.with({ path: path.dirname(document.uri.path) });
	return vscode.Uri.joinPath(parentUri, dirPrefix);
}

export function activate(context: vscode.ExtensionContext) {
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
		const dirUri = document.uri.with({ path: path.dirname(document.uri.path) });
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

	// The built-in Markdown language server only offers path completions inside
	// link syntax (`[](`, `[id]: `, `<img src="">`), so this provider offers
	// them inside inline code spans and fenced code blocks, where paths are
	// written bare. Prose outside both gets no path completions at all.
	//
	// `/` is the only trigger character, so `./`, `../`, `~/` and `/` all open
	// the suggest widget on their own. `.` is deliberately not one, since it
	// would fire on every `foo.bar` in a code block. `editor.quickSuggestions`
	// can't cover this on its own because it only auto-triggers on a word, and
	// `./` isn't one.
	const markdownPathCompletionProvider = vscode.languages.registerCompletionItemProvider(
		{ language: 'markdown' },
		{
			async provideCompletionItems(document, position) {
				if (document.isUntitled) {
					// A relative path has no directory to resolve against
					return [];
				}

				const linePrefix = document.lineAt(position).text.substring(0, position.character);
				// A ``` fence line is neither inline code (its three backticks
				// would read as an unclosed span) nor inside the block it opens
				// or closes
				if (isFenceLine(linePrefix)) {
					return [];
				}
				if (!isInInlineCode(linePrefix) && !isInFencedCodeBlock(document, position.line)) {
					return [];
				}

				// The path is the trailing run of characters before the cursor,
				// stopping at whitespace and at the delimiters that can open a
				// path, so `("./sr` yields `./sr`
				const pathPrefix = /[^\s()[\]<>`'"]*$/.exec(linePrefix)?.[0] ?? '';
				const dirPrefix = pathPrefix.substring(0, pathPrefix.lastIndexOf('/') + 1);
				const dirUri = resolvePathCompletionDir(document, dirPrefix);
				if (!dirUri) {
					return [];
				}

				let entries: [string, vscode.FileType][];
				try {
					entries = await vscode.workspace.fs.readDirectory(dirUri);
				} catch {
					return [];
				}

				// Replace only the last path segment, leaving `dirPrefix` alone
				const range = new vscode.Range(
					position.translate(0, dirPrefix.length - pathPrefix.length),
					position
				);

				return entries.map(([name, type]) => {
					// `type` is a bitmask, so a symlinked directory is
					// `Directory | SymbolicLink`
					const isDirectory = (type & vscode.FileType.Directory) !== 0;
					const label = isDirectory ? `${name}/` : name;
					const item = new vscode.CompletionItem(
						label,
						isDirectory ? vscode.CompletionItemKind.Folder : vscode.CompletionItemKind.File
					);
					item.range = range;
					item.insertText = label;
					if (isDirectory) {
						// Re-open the suggest widget so a directory can be
						// descended into without pressing `ctrl-space` again
						item.command = { command: 'editor.action.triggerSuggest', title: '' };
					}
					return item;
				});
			}
		},
		'/'
	);
	context.subscriptions.push(markdownPathCompletionProvider);

}

// This method is called when your extension is deactivated
export function deactivate() { }
