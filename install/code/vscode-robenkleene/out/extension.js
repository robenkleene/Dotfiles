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
const path = __importStar(require("path"));
const diffParser_1 = require("./diffParser");
const codePathParser_1 = require("./codePathParser");
const pairRanges_1 = require("./pairRanges");
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
// Returns the first and last lines of the paragraph containing `line`, where
// paragraphs are separated by blank lines
function paragraphLines(document, line) {
    // Whitespace-only lines count as blank, matching `cursorMove`'s blank line motions
    const isBlank = (line) => document.lineAt(line).isEmptyOrWhitespace;
    let firstLine = line;
    while (firstLine > 0 && !isBlank(firstLine - 1)) {
        firstLine--;
    }
    let lastLine = line;
    while (lastLine + 1 < document.lineCount && !isBlank(lastLine + 1)) {
        lastLine++;
    }
    return [firstLine, lastLine];
}
// Preserves the scheme and authority of `uri`, so paths on remote hosts stay
// remote instead of collapsing to a local `file:` URI.
function parentUri(uri) {
    return uri.with({ path: path.dirname(uri.path) });
}
function activate(context) {
    const openDirectory = async (uri, forceNewWindow) => {
        // `vscode.workspace.fs` instead of Node's `fs`, so directories on
        // remote hosts resolve through VS Code's file system providers
        const resourceUri = uri ?? vscode.window.activeTextEditor?.document.uri;
        if (!resourceUri) {
            return;
        }
        let dirUri;
        try {
            const stat = await vscode.workspace.fs.stat(resourceUri);
            const isDirectory = (stat.type & vscode.FileType.Directory) !== 0;
            dirUri = isDirectory ? resourceUri : parentUri(resourceUri);
        }
        catch {
            return;
        }
        await vscode.commands.executeCommand('vscode.openFolder', dirUri, { forceNewWindow });
    };
    let openDirectoryDisposable = vscode.commands.registerCommand('robenkleene.openDirectory', (uri) => {
        return openDirectory(uri, false);
    });
    context.subscriptions.push(openDirectoryDisposable);
    let openDirectoryInNewWindowDisposable = vscode.commands.registerCommand('robenkleene.openDirectoryInNewWindow', (uri) => openDirectory(uri, true));
    context.subscriptions.push(openDirectoryInNewWindowDisposable);
    let selectParagraphDisposable = vscode.commands.registerCommand('robenkleene.selectParagraph', () => {
        const editor = vscode.window.activeTextEditor;
        if (!editor) {
            return;
        }
        const document = editor.document;
        // From a blank line, take the paragraph below, like Emacs `mark-paragraph`
        let line = editor.selection.active.line;
        while (line < document.lineCount && document.lineAt(line).isEmptyOrWhitespace) {
            line++;
        }
        if (line >= document.lineCount) {
            return;
        }
        const [firstLine, lastLine] = paragraphLines(document, line);
        // End on the next line so the trailing newline is included, except at the
        // end of the document where there isn't one
        const end = lastLine + 1 < document.lineCount
            ? new vscode.Position(lastLine + 1, 0)
            : document.lineAt(lastLine).range.end;
        editor.selection = new vscode.Selection(new vscode.Position(firstLine, 0), end);
        editor.revealRange(new vscode.Range(end, end));
    });
    context.subscriptions.push(selectParagraphDisposable);
    // Adds quotes and brackets to Expand Selection, including inside comments and
    // strings, where VS Code's own bracket ranges don't apply. VS Code merges
    // these ranges with other providers' (e.g., Markdown's), so only Expand
    // Selection changes, unlike adding `brackets` to the language configuration.
    //
    // In prose, pairs are limited to the current paragraph so a stray bracket
    // doesn't match one far away. The paragraph itself is the outermost range, so
    // lists separated by a blank line expand one at a time, even though Markdown
    // treats them as a single loose list.
    //
    // In code, pairs are limited to the current line and no outermost range is
    // added. VS Code drops any range that doesn't contain the smaller ones, so a
    // paragraph partially overlapping a syntax node (e.g., a function body
    // ending mid-paragraph) would hide that node's range.
    const proseLanguages = ['markdown', 'plaintext'];
    const pairSelectionRangeProvider = vscode.languages.registerSelectionRangeProvider('*', {
        provideSelectionRanges(document, positions) {
            const isProse = proseLanguages.includes(document.languageId);
            return positions.map(position => {
                const [firstLine, lastLine] = isProse
                    ? paragraphLines(document, position.line)
                    : [position.line, position.line];
                const scopeStart = new vscode.Position(firstLine, 0);
                const scopeRange = new vscode.Range(scopeStart, document.lineAt(lastLine).range.end);
                const scopeOffset = document.offsetAt(scopeStart);
                const ranges = (0, pairRanges_1.enclosingPairRanges)(document.getText(scopeRange), document.offsetAt(position) - scopeOffset);
                // Chain from the outermost range inward, so each range's `parent` is
                // the next pair out
                let parent = isProse ? new vscode.SelectionRange(scopeRange) : undefined;
                for (const [start, end] of ranges.reverse()) {
                    parent = new vscode.SelectionRange(new vscode.Range(document.positionAt(scopeOffset + start), document.positionAt(scopeOffset + end)), parent);
                }
                // Every position needs a result, even outside any pair, so the
                // innermost range is the empty range at the cursor
                return new vscode.SelectionRange(new vscode.Range(position, position), parent);
            });
        }
    });
    context.subscriptions.push(pairSelectionRangeProvider);
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
    // A diff's paths are relative to wherever it was generated, which `code -`
    // doesn't pass along, so try the path in each workspace folder and keep the
    // ones that exist. Without a folder, use a saved diff's own directory.
    async function resolveDiffUris(document, filePath) {
        const folders = vscode.workspace.workspaceFolders ?? [];
        const bases = folders.length > 0
            ? folders.map(folder => folder.uri)
            : document.isUntitled ? [] : [parentUri(document.uri)];
        const tried = bases.map(base => vscode.Uri.joinPath(base, filePath));
        const exists = await Promise.all(tried.map(uri => vscode.workspace.fs.stat(uri).then(() => true, () => false)));
        return { uris: tried.filter((_, i) => exists[i]), tried };
    }
    function displayPath(uri) {
        const homeDir = getHomeDir(uri.path);
        return homeDir ? `~${uri.path.substring(homeDir.length)}` : uri.path;
    }
    const diffDefinitionProvider = vscode.languages.registerDefinitionProvider({ language: 'diff' }, {
        async provideDefinition(document, position) {
            const result = (0, diffParser_1.parseDiffLocation)(document.getText(), position.line);
            if (!result) {
                return null;
            }
            // Several locations show VS Code's peek view to choose between them
            const { uris } = await resolveDiffUris(document, result.filePath);
            const targetLine = result.line - 1;
            const targetCol = Math.max(position.character - 1, 0);
            const targetPos = new vscode.Position(targetLine, targetCol);
            return uris.map(uri => new vscode.Location(uri, targetPos));
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
        const { uris, tried } = await resolveDiffUris(document, result.filePath);
        if (uris.length === 0) {
            vscode.window.showErrorMessage(`Could not find file, tried: ${tried.map(displayPath).join(', ')}`);
            return;
        }
        let uri = uris[0];
        if (uris.length > 1) {
            const picked = await vscode.window.showQuickPick(uris.map(uri => ({ label: displayPath(uri), uri })), { placeHolder: `Multiple matches for ${result.filePath}` });
            uri = picked?.uri;
            if (!uri) {
                return;
            }
        }
        try {
            const targetDoc = await vscode.workspace.openTextDocument(uri);
            const targetLine = result.line - 1;
            const targetCol = Math.max(cursorCol - 1, 0);
            const pos = new vscode.Position(targetLine, targetCol);
            await vscode.window.showTextDocument(targetDoc, { selection: new vscode.Range(pos, pos) });
        }
        catch {
            vscode.window.showErrorMessage(`Could not open file: ${uri.toString()}`);
        }
    });
    context.subscriptions.push(diffGotoSourceDisposable);
    // The URI whose scheme, authority, and home directory absolute paths resolve
    // against. `untitled:` documents don't have a path, so use the workspace
    // folder to stay on remote hosts, or the local home directory when there's
    // no folder in a local window.
    function absolutePathBaseUri(document) {
        if (!document.isUntitled) {
            return document.uri;
        }
        const folderUri = vscode.workspace.workspaceFolders?.[0]?.uri;
        if (folderUri) {
            return folderUri;
        }
        // `os.homedir()` is the local home directory, which is wrong for remotes
        if (vscode.env.remoteName) {
            return null;
        }
        return vscode.Uri.file(os.homedir());
    }
    // Resolves the directory part of a typed path: `~/` from the home directory
    // in the document's path, `/` from the root, and anything else from the
    // document's directory, like Markdown's `[](...)` path completion
    function resolveCompletionDir(document, dir) {
        if (dir.startsWith('~/') || dir.startsWith('/')) {
            const baseUri = absolutePathBaseUri(document);
            if (!baseUri) {
                return null;
            }
            if (dir.startsWith('/')) {
                return baseUri.with({ path: dir });
            }
            const homeDir = getHomeDir(baseUri.path);
            if (!homeDir) {
                return null;
            }
            return baseUri.with({ path: path.posix.join(homeDir, dir.substring(2)) });
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
    const codePathCompletionProvider = vscode.languages.registerCompletionItemProvider({ language: 'markdown' }, {
        async provideCompletionItems(document, position) {
            const prefix = (0, codePathParser_1.parseCodePathPrefix)(document.getText(), position.line, position.character);
            if (!prefix) {
                return null;
            }
            const dirUri = resolveCompletionDir(document, prefix.dir);
            if (!dirUri) {
                return null;
            }
            let entries;
            try {
                entries = await vscode.workspace.fs.readDirectory(dirUri);
            }
            catch {
                return null;
            }
            const range = new vscode.Range(position.translate(0, -prefix.partial.length), position);
            return entries.map(([name, type]) => {
                const isDirectory = (type & vscode.FileType.Directory) !== 0;
                const item = new vscode.CompletionItem(name, isDirectory ? vscode.CompletionItemKind.Folder : vscode.CompletionItemKind.File);
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
    });
    context.subscriptions.push(codePathCompletionProvider);
}
exports.activate = activate;
// This method is called when your extension is deactivated
function deactivate() { }
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map