" Space Buffer
set statusline=\ 
set statusline+=%{hostname()}\ 
" Working Directory
set statusline+=%.40{pathshorten(fnamemodify(getcwd(win_getid()),':~'))}\ 
" Machine Name
" Truncate Marker
set statusline+=%<
" Filename
set statusline+=%(%.40{&filetype=='netrw'?b:netrw_curdir:(expand('%:t')!=''?expand('%:~:.'):'[No\ Name]')}\ %)
" Filetype
set statusline+=%y\ 
" %m: Modified
set statusline+=%(%m\ %)
" %r: Read-only mode
set statusline+=%(%r\ %)
" %h: Read-only
set statusline+=%(%h\ %)
" Switch to right
set statusline+=%=
" Line/Column/Location
set statusline+=%l:%c\ %P
" Space Buffer
set statusline+=\ 
