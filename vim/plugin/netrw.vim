" Hide dot files in file list (`gh` to toggle in `vim-vinegar`)
"let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" Sort case-insensitive
"let g:netrw_sort_options = "i"
" Faster `netrw` but clibpoard might get clobbered
" This doesn't seem to make a difference
" let g:netrw_clipboard = 0
" Don't automatically enter directories when clicking them (instead just move
" the cursor)
" This is more consistent with how, e.g., the quickfix list works, where
" clicking an entry only moves the cursor without jumping to the match.
let g:netrw_mousemaps = 0
" Put netrw directories into the jumplist
" This appears to break the jumplist, use `-` instead
" let g:netrw_keepj = ""
" The `g:netrw_gx` variable determines how `netrw` identifies URLs, by default
" this is set to `<cfile>`, which uses `isfname` variable to determine what to
" use as the URL
