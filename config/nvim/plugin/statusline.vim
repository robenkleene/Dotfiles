highlight User1 guifg=lightblue
" Space Buffer
set statusline=\ 
" Working Directory
" set statusline+=%.20{fnamemodify(getcwd(win_getid()),':~')}\ 
set statusline+=%1*%.20{pathshorten(fnamemodify(getcwd(win_getid()),':~'))}%*\ 
" Truncate Marker
set statusline+=%<
" Filename
" set statusline+=%.40f
" set statusline+=%.40{pathshorten(expand('%:~:.'))}
" The number is the maximum number of characters to use
set statusline+=%.100{expand('%:t')}
" Modified
set statusline+=%m 
" Filetype
set statusline+=\ %y
" Switch to right
set statusline+=%=
" Line/Column
set statusline+=\ %l:%c
" Location
set statusline+=\ %P
" Space Buffer
set statusline+=\ 
