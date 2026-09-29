"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.parseCodePathPrefix = void 0;
// Whether `targetLine` is inside a fenced code block, opened with ``` or `~~~`
function isInFencedBlock(lines, targetLine) {
    let openFence = null;
    for (let i = 0; i < targetLine; i++) {
        const match = lines[i].match(/^ {0,3}(`{3,}|~{3,})/);
        if (!match) {
            continue;
        }
        const fence = match[1];
        if (openFence === null) {
            openFence = fence;
        }
        else if (fence[0] === openFence[0] && fence.length >= openFence.length) {
            openFence = null;
        }
    }
    return openFence !== null;
}
// Returns the path being typed at the cursor if the cursor is in an inline code
// span (after an unmatched `` ` ``) or a fenced code block, otherwise `null`
function parseCodePathPrefix(text, targetLine, character) {
    const lines = text.split('\n');
    if (targetLine < 0 || targetLine >= lines.length) {
        return null;
    }
    const before = lines[targetLine].substring(0, character);
    const backtickCount = (before.match(/`/g) ?? []).length;
    const inInlineCode = backtickCount % 2 === 1;
    if (!inInlineCode && !isInFencedBlock(lines, targetLine)) {
        return null;
    }
    // A fence line itself (e.g., ```` ``` ````) isn't a place to type a path
    if (/^ {0,3}(`{3,}|~{3,})/.test(lines[targetLine])) {
        return null;
    }
    const token = before.match(/[^\s`'"()<>\[\]]*$/)?.[0] ?? '';
    const slashIndex = token.lastIndexOf('/');
    return {
        dir: token.substring(0, slashIndex + 1),
        partial: token.substring(slashIndex + 1),
    };
}
exports.parseCodePathPrefix = parseCodePathPrefix;
//# sourceMappingURL=codePathParser.js.map