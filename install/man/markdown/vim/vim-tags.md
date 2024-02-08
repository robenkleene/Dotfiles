- `<C-]>`: Jump to definition of the keyword under the cursor (this adds it to the `tagstack`)
- `<C-w><C-]>`: Open tag under cursor in a new split
- `<C-w>v <C-]>`: Open tag under cursor in a new vertical split
- `<C-w>s <C-w>T<C-]>`: Open tag under cursor in a new vertical split
- `<C-t>`: Jump backward in the `tagstack` (`<C-o>` can usually also be used instead, which uses the `jumplist`)
- `:[ta]g`: Jump to the next entry in the `tagstack`
- `g]`: Show a list for matches of the item under the cursor
- `:[ts]elect`: Show the matches in the `tag-matchlist`
- `:[ts]elect /`: Shows matches for the current file first (this works because `/` starts a regular expression tag search and an empty search matches all tags, and since `:tselect` prioritizes tags in the current file, this command lists the matches in the current file first)
- `:[tn]ext`: Jump to the next match
- `:[tp]revious`: Jump the previous match
- `:tags`: Show the contents of the `tagstack`

# Files

When `ctags` is run with the `--extra=+f` flag, then `:tag <filename>` will open that file
