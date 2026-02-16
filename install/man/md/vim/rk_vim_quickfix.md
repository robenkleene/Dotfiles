- `:cope[n] [height]` / `:ccl[ose]`: Open / close the `quickfix` window, optionally with a `[height]` (this works if the `quickfix` list is already visible)
- `:cn[ext]` / `:[cp]rev`: Next / previous `quickfix` error

# Populating

- `:cb[uffer]`: Populate the `quickfix` list from the results in the current window (this works for either `grep` formatted output or `make` output)
- `cexpr []`: Clear the `quickfix` list

# Resizing

- `:[cw]indow [height]`: Open `quickfix` window if there are errors, close it if there are not errors, optionally with a `[height]` (note that this cannot change the height if the `quickfix` list is already visible)
- `:res[ize] [N]`: Can also be used to set the `quickfix` list to a height `[N]`

# History

- `:chi[story]`: Show list of error lists with the current list marked
- `:col[der]`: Go to previous `quickfix` list
- `:cnew[er]`: Go to next `quickfix` list

# Search

- `:vim[grep]` then `C-r C-w` then `%` to make `:vimgrep <current-word> %` is a nice way to transfer the current search term to the `quickfix` list (`C-r C-w` inserts the word at the cursor)

# Mass Edits

- `:cdo`: Do command to each entry in the `quickfix` list, e.g., `:cdo s/this/that/g`
- `:cfdo`: Do command to each file in the `quickfix` list, e.g., `:cfdo %s/this/that/g`

## More Mass Edit Examples

On each entry in the `quickfix` list:

- `:cdo s/foo/bar/g`: Replace `this` with `that` on each entry (add the `e` flag [e.g., `s/foo/bar/ge`] to suppress errors for lines that contain no matches)
- `:cdo norm @a`: Perform the macro in register `a` on each entry
- `:cdo norm gcc`: Comment out each entry (with `vim-commentary`)
- `:cdo norm Oprint("got here")`: Add `print("got here")` above each matching line (this uses `O` to open a line above [which should also use consistent indentation], note that exiting normal mode can be omitted)

# Filter

Requires `packadd cfilter`.

- `:Cfilter`: Filter the error list by a pattern

# Other

Populating the `quickfix` window with an arbitrary command:

	:cexpr system('rg --vimgrep pathForResource -g "*.swift" \| grep -v func')

(Note a bug in `nvim` seemingly stops this from working multiple times in one session.)
