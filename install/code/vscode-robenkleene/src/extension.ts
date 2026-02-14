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

	function resolveDiffPath(document: vscode.TextDocument, filePath: string): string {
		const workspaceFolder = vscode.workspace.workspaceFolders?.[0];
		if (workspaceFolder) {
			return path.join(workspaceFolder.uri.fsPath, filePath);
		}
		return path.join(path.dirname(document.uri.fsPath), filePath);
	}

	const diffDefinitionProvider = vscode.languages.registerDefinitionProvider(
		{ language: 'diff' },
		{
			provideDefinition(document, position) {
				const result = parseDiffLocation(document.getText(), position.line);
				if (!result) {
					return null;
				}
				const resolvedPath = resolveDiffPath(document, result.filePath);
				const targetLine = result.line - 1;
				const targetCol = Math.max(position.character - 1, 0);
				const targetPos = new vscode.Position(targetLine, targetCol);
				return new vscode.Location(vscode.Uri.file(resolvedPath), targetPos);
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

		const resolvedPath = resolveDiffPath(document, result.filePath);
		const uri = vscode.Uri.file(resolvedPath);
		try {
			const targetDoc = await vscode.workspace.openTextDocument(uri);
			const targetLine = result.line - 1;
			const targetCol = Math.max(cursorCol - 1, 0);
			const pos = new vscode.Position(targetLine, targetCol);
			await vscode.window.showTextDocument(targetDoc, { selection: new vscode.Range(pos, pos) });
		} catch {
			vscode.window.showErrorMessage(`Could not open file: ${resolvedPath}`);
		}
	});
	context.subscriptions.push(diffGotoSourceDisposable);

}

// This method is called when your extension is deactivated
export function deactivate() { }
