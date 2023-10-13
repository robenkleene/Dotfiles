%

# `vim` Search, Find & Replace

See [`vim-quickfix.md`](vim-quickfix.md) for more.

## Search

- `n`: Next search
- `N`: Previous search

## `grep`

- `:%s/this/that/gc`: Replace this with that, asking for confirmation each time
- `:g/pid/d`: Delete lines matching pattern
- `:v/pid/d` or `g!/foo/d`: Delete all other lines (`v` is for `in*v*erse`)
- `:g/cfcfcf/p`: Print lines matching pattern
- `:g/cfcfcf/yank A`: Yank matching lines to register `a` (this works because `A` is uppercase, so the lines are *appended* to the register, this is why this can't be used to yank directly to the system clipboard)
- `:%s#this#that#g`: Alternative find and replace separator for when the find and replace strings have slashes
- `:g//norm gcc`: Perform a normal mode command on every matched search

## `vimgrep`

- `:vim[grep] {pattern} ##`: Search `args` (`##`) and populate the `quickfix` list with the results.
- `:vim[grep] {pattern} %`: Populate the `quickfix` list with matches of the pattern in the current file
- `:bufdo vimgrepa[dd] {pattern} %`: Populate the `quickfix` list with matches of the pattern in the current file

Add `| copen` to the end of any of the above to show the `quickfix` list.

## `windo`

- `windo %s/foo/bar/g`: Replace in all open windows

## Replace

- `s/foo/bar`
- `s#foo#bar`: Alternative syntax, very useful for replaces that involve a lot of slashes.

## Using `gn`

**Visual Method**: After doing a search, type `gn` to select the next match, then type `n` to go to the next match, then `gn` again to select, then `.` to perform the previous operation.

**Motion Method**: Do a motion edit like `cgn`, this will edit the next match, after the edit hit the `.` to perform the same operation on the next match automatically.

- `dgn`: Delete the next match
