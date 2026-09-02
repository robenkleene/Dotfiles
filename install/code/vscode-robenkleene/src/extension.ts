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

// Preserves the scheme and authority of `uri`, so paths on remote hosts stay
// remote instead of collapsing to a local `file:` URI.
function parentUri(uri: vscode.Uri): vscode.Uri {
	return uri.with({ path: path.dirname(uri.path) });
}

export function activate(context: vscode.ExtensionContext) {
	let openDirectoryDisposable = vscode.commands.registerCommand(
		'robenkleene.openDirectory',
		async (uri?: vscode.Uri) => {
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
			await vscode.commands.executeCommand('vscode.openFolder', dirUri);
		}
	);
	context.subscriptions.push(openDirectoryDisposable);

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

}

// This method is called when your extension is deactivated
export function deactivate() { }
