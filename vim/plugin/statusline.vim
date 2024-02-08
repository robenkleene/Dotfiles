" Space Buffer
set statusline=\ 
" Working Directory
set statusline+=%#netrwDir#%.40{pathshorten(fnamemodify(getcwd(win_getid()),':~'))}%*\ 
" Truncate Marker
set statusline+=%<
" Filename
set statusline+=%(%.40{expand('%:t')}\ %)
"                                      ^^ End group
"                   ^^ Maximum number of characters
"               ^^ Start group that disappears if flags are empty
" Modified
set statusline+=%(%#ErrorMsg#%m%*\ %)
" Filetype
set statusline+=%y
" Switch to right
set statusline+=%=
" Line/Column
set statusline+=\ %l:%c
" Location
set statusline+=\ %P
" Space Buffer
set statusline+=\ 
