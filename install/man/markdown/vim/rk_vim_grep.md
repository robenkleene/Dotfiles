# `rg` & `fd`

- `!rg <term>` to view results
- `0r !rg <term>` then `:cb[uffer]` to move results to quickfix
- "arg `fd <term>`" to populate args list
- If the above won't work with spaces just append `:1` to each line and use `:cbuffer`

# `grep`

- `:%s/this/that/gc`: Replace this with that, asking for confirmation each time
- `:g/pid/d`: Delete lines matching pattern
- `:v/pid/d` or `g!/foo/d`: Delete all other lines (`v` is for `in*v*erse`)
- `:g/cfcfcf/p`: Print lines matching pattern
- `:g/cfcfcf/yank A`: Yank matching lines to register `a` (this works because `A` is uppercase, so the lines are *appended* to the register, this is why this can't be used to yank directly to the system clipboard)
- `:%s#this#that#g`: Alternative find and replace separator for when the find and replace strings have slashes
- `:g//norm gcc`: Perform a normal mode command on every matched search

# `vimgrep`

- `:vim[grep] {pattern} ##`: Search `args` (`##`) and populate the `quickfix` list with the results.
- `:vim[grep] {pattern} %`: Populate the `quickfix` list with matches of the pattern in the current file
- `:bufdo vimgrepa[dd] {pattern} %`: Populate the `quickfix` list with matches of the pattern in the current file
- `:vim[grep]` then `C-r C-w` then `%` to make `:vimgrep <current-word> %` is a nice way to transfer the current search term to the `quickfix` list (`C-r C-w` inserts the word at the cursor)

Add `| copen` to the end of any of the above to show the `quickfix` list.
