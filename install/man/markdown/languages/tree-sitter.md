# Tree Sitter

- `token.immediate("#")`: Only match the token if it isn't preceded by extras (like whitespace)

## Grammar

- `terminal` and `non-terminal`: When parsing a tree, "terminals" are the leaf nodes, because they terminate the branch. This means terminals only appear in the grammar rules, and not in the input. ("name" might be a non-terminal, and "joe" a terminal.)
- `production`: A rule, because rules "produce" strings of characters
- `context-free grammar` vs. `context-sensitive grammar`: 

## Syntax Groups

- `:TSCaptureUnderCursor`: Show groups under cursor
