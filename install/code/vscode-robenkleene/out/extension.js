"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deactivate = exports.activate = void 0;
const vscode = __importStar(require("vscode"));
const path = __importStar(require("path"));
const diffParser_1 = require("./diffParser");
// There's no VS Code extension API to get the remote home directory from a UI
// extension (`os.homedir()` returns the local home dir, not the remote). We
// parse it from the file path instead, so the extension can run as a UI
// extension without needing to be installed on remote servers.
function getHomeDir(filePath) {
    let match = filePath.match(/^(\/home\/[^/]+)/);
    if (match)
        return match[1];
    match = filePath.match(/^(\/Users\/[^/]+)/);
    if (match)
        return match[1];
    if (filePath.startsWith('/root/'))
        return '/root';
    return null;
}
function activate(context) {
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
        let result;
        if (selection && !selection.isEmpty) {
            const text = document.getText(selection);
            const lang = document.languageId;
            result = `\`\`\` grep\n${location}\n\`\`\`\n\n\`\`\` ${lang}\n${text}\n\`\`\``;
        }
        else {
            result = location;
        }
        vscode.env.clipboard.writeText(result).then(() => {
            vscode.window.showInformationMessage(`${result}`);
        });
    });
    context.subscriptions.push(copyGrepMarkdownDisposable);
    function resolveDiffPath(document, filePath) {
        const workspaceFolder = vscode.workspace.workspaceFolders?.[0];
        if (workspaceFolder) {
            return path.join(workspaceFolder.uri.fsPath, filePath);
        }
        return path.join(path.dirname(document.uri.fsPath), filePath);
    }
    const diffDefinitionProvider = vscode.languages.registerDefinitionProvider({ language: 'diff' }, {
        provideDefinition(document, position) {
            const result = (0, diffParser_1.parseDiffLocation)(document.getText(), position.line);
            if (!result) {
                return null;
            }
            const resolvedPath = resolveDiffPath(document, result.filePath);
            const targetLine = result.line - 1;
            const targetCol = Math.max(position.character - 1, 0);
            const targetPos = new vscode.Position(targetLine, targetCol);
            return new vscode.Location(vscode.Uri.file(resolvedPath), targetPos);
        }
    });
    context.subscriptions.push(diffDefinitionProvider);
    let diffGotoSourceDisposable = vscode.commands.registerCommand('robenkleene.diffGotoSource', async () => {
        const editor = vscode.window.activeTextEditor;
        if (!editor) {
            return;
        }
        const document = editor.document;
        const cursorLine = editor.selection.active.line;
        const cursorCol = editor.selection.active.character;
        const result = (0, diffParser_1.parseDiffLocation)(document.getText(), cursorLine);
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
        }
        catch {
            vscode.window.showErrorMessage(`Could not open file: ${resolvedPath}`);
        }
    });
    context.subscriptions.push(diffGotoSourceDisposable);
}
exports.activate = activate;
// This method is called when your extension is deactivated
function deactivate() { }
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map