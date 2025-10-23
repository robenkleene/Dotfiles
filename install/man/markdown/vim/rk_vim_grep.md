# `rg` & `fd`

- `!rg <term>` to view results
- `0r !rg <term>` then `:cb[uffer]` to move results to quickfix
- `:arg <backtick>fd <term><backtick>` to populate argument list
- If the above won't work with spaces just append `:1` to each line and use `:cbuffer`

# `grep`

- `:%s/foo/bar/gc`: Replace this with that, asking for confirmation each time
- `:g/foo/d`: Delete lines matching pattern
- `:bufdo g/foo/d`: Delete lines matching pattern in all buffers
- `:v/foo/d`, `g!/foo/d`: Delete all other lines (`:v` and `g!` are synonyms)
- `:g/foo/p`: Print lines matching pattern (to then populate the quick fix list with the pattern, use `:vim[grep] /foo/ %`
- `:g/foo/yank A`: Yank matching lines to register `a` (this works because `A` is uppercase, so the lines are *appended* to the register, this is why this can't be used to yank directly to the system clipboard)
- `:%s#foo#bar#g`: Alternative find and replace separator for when the find and replace strings have slashes
- `:g//norm gcc`: Perform a normal mode command on every matched search

# `vimgrep`

- `:vim[grep] {pattern} ##`: Search `args` (`##`) and populate the `quickfix` list with the results.
- `:vim[grep] {pattern} %`: Populate the `quickfix` list with matches of the pattern in the current file
- `:bufdo vimgrepa[dd] {pattern} %`: Populate the `quickfix` list with matches of the pattern in the current file
- `:vim[grep]` then `C-r C-w` then `%` to make `:vimgrep <current-word> %` is a nice way to transfer the current search term to the `quickfix` list (`C-r C-w` inserts the word at the cursor)

Add `| copen` to the end of any of the above to show the `quickfix` list.
