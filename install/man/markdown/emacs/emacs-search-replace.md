%

# `emacs` Find & Replace

- `M-s .` (`isearch-forward-symbol-at-point`): Search for symbol at point
    - These searches go to a different ring than regular searches, to get a previous symbol search, start the search with `M-s _`

## Search

- `C-s` / `C-r`: Incremental search forward / backward
- `C-M-s` / `C-M-r`: Incremental regular expression search forward / backward
- `C-r`: Backward
- `C-g`: Cancel

### Incremental Search

- `M-e`: Edit the current incremental search
- `C-g`: Cancel the current incremental search
- `↩`: Go to the current match
- `M-r`: Switch incremental search to regular expression
- `M-%`: Start a query replace with the current search term (this will be a regular expression replace if the initial `isearch` was regular expression, either by starting it with `C-M-s` / `C-M-r`, or by hitting `M-r` to toggle to regular expressions)
- `C-v` / `M-v`: Previous / next page of search results (requires `isearch-allow-motion`)
- `M-<` / `M->`: Go to first / last match (requires `isearch-allow-motion`)

### Special

- `M-s .`: Search for symbol at point
- `M-s M-.`: Search for thing at point
- `M-s w`: Word search
- `M-s _`: Symbol search

## Replace

- `M-%`: Find & replace
- `C-M-%`: Regular expression find & replace

### Active Replace

- `!`: Replace to the end of the file
- `␣` or `Y`: One replacement
- `q` or `↩`: Exit

## Compilation Errors & `grep`

- `C-x <backtick>` or `M-g n` / `M-g p`: Next/previous Error
- You can clear the current grep search by `kill-this-buffer` on the `*grep*` buffer

## Special

- `highlight-regex`: Highlight regular expression
- `highlight-phrase`: Highlight case-insensitive with spaces
