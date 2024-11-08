# Search

- `C-s` / `C-r`: Incremental search forward / backward
- `C-M-s` / `C-M-r`: Incremental regular expression search forward / backward
- `C-r`: Backward
- `C-g`: Cancel

## Incremental Search

- `M-e`: Edit the current incremental search (normally focus isn't in the minibuffer during incremental search, it's in the document, this means to do more complex edits [e.g., to move by word], `M-e` should be used to move focus to the minibuffer first)
- `C-g`: Cancel the current incremental search
- `↩`: Go to the current match
- `M-r`: Switch incremental search to regular expression
- `M-%`: Start a query replace with the current search term (this will be a regular expression replace if the initial `isearch` was regular expression, either by starting it with `C-M-s` / `C-M-r`, or by hitting `M-r` to toggle to regular expressions)
- `C-v` / `M-v`: Previous / next page of search results (requires `isearch-allow-motion`)
- `M-<` / `M->`: Go to first / last match (requires `isearch-allow-motion`)

## Special

These searches go to a different ring than regular searches, to get a previous symbol search, start the search with `M-s _`.

- `M-s .` (`isearch-forward-symbol-at-point`): Search for symbol at point
- `M-s M-.`: Search for thing at point
- `M-s w`: Word search
- `M-s _`: Symbol search

# Replace

- `M-%`: Find & replace
- `C-M-%`: Regular expression find & replace (doesn't work in terminal Emacs)

## From Incremental Search

This is the best approach that also works on terminal.

1. Start a regular expression incremental search (`C-M-s`)
2. Enter the search term and hit `M-%` to switch to a query replace
3. Enter the replace term and hit enter
4. Hit `!` to apply the replace

## Replace Bindings

- `!`: Replace to the end of the file
- `␣` or `Y`: One replacement
- `q` or `↩`: Exit

# Compilation Errors & `grep`

- `C-x <backtick>` or `M-g n` / `M-g p`: Next/previous Error
- You can clear the current grep search by `kill-this-buffer` on the `*grep*` buffer

# Special

- `highlight-regex`: Highlight regular expression
- `highlight-phrase`: Highlight case-insensitive with spaces

# Region

Emacs doesn't have a built-in way to only `query-replace` in a region, but there are a couple of alternatives:

- Just use a regular `query-replace` without a region selected and just hit `␣` until all the desired matches are replaced
- Select a region, use `C-x n n` to narrow to that region, do a `query-replace` and hit `!` to replace all matches, and use `C-x n p` to exit narrowing
