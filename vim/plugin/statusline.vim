" Space Buffer
set statusline=\ 
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
" Truncate Marker
set statusline+=%<
" Machine Name and Working Directory
" The host is a separate item so truncating a long path doesn't cut it off
set statusline+=%{substitute(hostname(),'\\..*','','')}:
set statusline+=%.40{pathshorten(fnamemodify(getcwd(win_getid()),':~'))}\ 
" Switch to right
set statusline+=%=
" Line/Column/Location
set statusline+=%l:%c\ %P
" Space Buffer
set statusline+=\ 
