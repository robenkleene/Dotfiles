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
}
exports.activate = activate;
// This method is called when your extension is deactivated
function deactivate() { }
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map