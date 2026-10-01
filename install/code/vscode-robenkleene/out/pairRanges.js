"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.enclosingPairRanges = void 0;
// Brackets nest, so they're matched with a stack across lines
const BRACKETS = [['(', ')'], ['[', ']'], ['{', '}'], ['“', '”']];
// Quotes don't nest, so they're paired left to right within a single line.
// `isApostrophe` quotes double as apostrophes in prose (e.g., `don't`), so
// they only open after a non-word character and only close before one.
const QUOTES = [
    { open: '"', close: '"', isApostrophe: false },
    { open: '`', close: '`', isApostrophe: false },
    { open: '\'', close: '\'', isApostrophe: true },
    { open: '‘', close: '’', isApostrophe: true },
];
const isWordChar = (char) => char !== undefined && /[\p{L}\p{N}]/u.test(char);
// Returns `[openIndex, closeIndex]` for each matched bracket pair in `text`.
// A closer that doesn't match the innermost opener is ignored, so stray
// closers like the `)` in `1)` don't unbalance the rest of the text.
function bracketPairs(text) {
    const pairs = [];
    const stack = [];
    for (let i = 0; i < text.length; i++) {
        const char = text[i];
        const bracket = BRACKETS.find(([open]) => open === char);
        if (bracket) {
            stack.push({ index: i, close: bracket[1] });
        }
        else if (stack.length && stack[stack.length - 1].close === char) {
            pairs.push([stack.pop().index, i]);
        }
    }
    return pairs;
}
// Returns `[openIndex, closeIndex]` for each quote pair in the line of `text`
// spanning `lineStart` to `lineEnd`
function quotePairs(text, lineStart, lineEnd) {
    const pairs = [];
    for (const quote of QUOTES) {
        let openIndex = null;
        for (let i = lineStart; i < lineEnd; i++) {
            const char = text[i];
            if (openIndex === null) {
                if (char === quote.open && !(quote.isApostrophe && isWordChar(text[i - 1]))) {
                    openIndex = i;
                }
            }
            else if (char === quote.close && !(quote.isApostrophe && isWordChar(text[i + 1]))) {
                pairs.push([openIndex, i]);
                openIndex = null;
            }
        }
    }
    return pairs;
}
// Returns `[start, end]` offsets for the contents and the whole of every pair
// in `text` that encloses `offset`, smallest first. Ranges that only partially
// overlap a smaller range (e.g., `"` quotes crossing a `(`) are dropped, so
// each range contains the one before it.
function enclosingPairRanges(text, offset) {
    const lineStart = text.lastIndexOf('\n', offset - 1) + 1;
    const newlineIndex = text.indexOf('\n', offset);
    const lineEnd = newlineIndex === -1 ? text.length : newlineIndex;
    const ranges = [];
    for (const [open, close] of [...bracketPairs(text), ...quotePairs(text, lineStart, lineEnd)]) {
        if (open < offset && offset <= close) {
            // Skip empty contents, e.g., `()`
            if (open + 1 < close) {
                ranges.push([open + 1, close]);
            }
            ranges.push([open, close + 1]);
        }
    }
    ranges.sort((a, b) => (a[1] - a[0]) - (b[1] - b[0]));
    const nested = [];
    for (const range of ranges) {
        const previous = nested[nested.length - 1];
        if (!previous || (range[0] <= previous[0] && previous[1] <= range[1] && (range[0] !== previous[0] || range[1] !== previous[1]))) {
            nested.push(range);
        }
    }
    return nested;
}
exports.enclosingPairRanges = enclosingPairRanges;
//# sourceMappingURL=pairRanges.js.map