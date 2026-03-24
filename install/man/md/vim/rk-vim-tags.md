# Bindings

- `<C-]>`: Jump to definition of the keyword under the cursor (this adds it to the `tagstack`)
- `<C-w><C-]>`: Open tag under cursor in a new split
- `<C-w>v<C-]>`: Open tag under cursor in a new vertical split (note this is two separate commands, not a special binding)
- `<C-w><C-]><C-w>T`: Open tag under cursor in a new tab (note this is two separate commands, not a special binding)
- `g]`: Show a list for matches of the item under the cursor
- `<C-w>g]`: Show a list for matches of the item under the cursor and open the choice in a new split (there are no other split options, so use `<C-w>v` first for example)
- `<C-t>`: Jump backward in the `tagstack` (`<C-o>` can usually also be used instead, which uses the `jumplist`)

# Commands

- `:[ts]elect`: Show the matches in the `tag-matchlist`
- `:[ts]elect /`: Shows matches for the current file first (this works because `/` starts a regular expression tag search and an empty search matches all tags, and since `:tselect` prioritizes tags in the current file, this command lists the matches in the current file first)
- `:[tn]ext`: Jump to the next match
- `:[tp]revious`: Jump the previous match
- `:tags`: Show the contents of the `tagstack`
- `:ta[g] <tag>`: Jump to tag (there's no way to target a split, so use `<C-w>s` first for example)

# Files

When `ctags` is run with the `--extra=+f` flag, then `:tag <filename>` will open that file
