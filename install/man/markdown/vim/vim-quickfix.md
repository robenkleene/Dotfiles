# Navigating

- `:cnext` / `:cprev`: Next / previous `quickfix` error
- `:[cw]indow [height]`: Open `quickfix` window if there are errors, close it if there are not errors, optionally with a `[height]` (note that this cannot change the height if the `quickfix` list is already visible)
- `:cope[n] [height]`: Show `quickfix` window, optionally with a `[height]` (this works if the `quickfix` list is already visible)
- `:res[ize] [N]`: Can also be used to set the `quickfix` list to a height `[N]`
- `:ccl[ose]`: Close `quickfix` window
- `:cb[uffer]`: Populate the `quickfix` list from the results in the current window
- `:col[der]`: Go to previous `quickfix` list
- `:cnew[er]`: Go to next `quickfix` list

# Mass Edits

- `:cdo`: Do command to each entry in the `quickfix` list, e.g., `:cdo s/this/that/g`
- `:cfdo`: Do command to each file in the `quickfix` list, e.g., `:cfdo %s/this/that/g`

## Examples

On each entry in the `quickfix` list:

- `:cdo s/this/that/g`: Replace `this` with `that` on each entry
    - Add the `e` flag (e.g., `s/this/that/ge`) to suppress errors for lines that contain no matches
- `:cdo norm @q`: Perform the macro in register `q` on each entry
- `:cdo norm gcc`: Comment out each entry

# Other

Populating the `quickfix` window with an arbitrary command:

	:cexpr system('rg --vimgrep pathForResource -g "*.swift" \| grep -v func')

(Note a bug in `nvim` seemingly stops this from working multiple times in one session.)
