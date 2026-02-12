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
const os = __importStar(require("os"));
function activate(context) {
    let openFolderForFileDisposable = vscode.commands.registerCommand("robenkleene.openDirectory", async (uri) => {
        var dirUri;
        var fileUri;
        const fs = require("fs");
        var path = require("path");
        if (uri) {
            if (fs.lstatSync(uri.fsPath).isDirectory()) {
                // Use the selected directory in the file explorer
                dirUri = uri;
            }
            else {
                fileUri = uri;
                const dirPath = path.dirname(fileUri.fsPath);
                dirUri = vscode.Uri.file(dirPath);
            }
        }
        else {
            // Or if a valid directory wasn't passed in, use the directory of the current file
            const activeTextEditor = vscode.window.activeTextEditor;
            if (!activeTextEditor) {
                return;
            }
            fileUri = activeTextEditor.document.uri;
            let filePath = activeTextEditor.document.uri.fsPath;
            const dirPath = path.dirname(filePath);
            if (!fs.lstatSync(dirPath).isDirectory()) {
                return;
            }
            dirUri = vscode.Uri.file(dirPath);
        }
        if (!fs.existsSync(dirUri.fsPath)) {
            return;
        }
        await vscode.commands.executeCommand("vscode.openFolder", dirUri);
    });
    context.subscriptions.push(openFolderForFileDisposable);
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
        const homeDir = os.homedir();
        if (filePath.startsWith(homeDir)) {
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
}
exports.activate = activate;
// This method is called when your extension is deactivated
function deactivate() { }
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map