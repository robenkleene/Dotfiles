highlight User1 guifg=lightblue
highlight User2 guifg=yellow
highlight User3 guifg=darkgray
" Space Buffer
set statusline=\ 
" Working Directory
" set statusline+=%.20{fnamemodify(getcwd(win_getid()),':~')}\ 
set statusline+=%1*%.40{pathshorten(fnamemodify(getcwd(win_getid()),':~'))}%*\ 
" Truncate Marker
set statusline+=%<
" Filename
" set statusline+=%.40f
" set statusline+=%.40{pathshorten(expand('%:~:.'))}
" The number is the maximum number of characters to use
set statusline+=%(%.40{expand('%:t')}\ %)
" Modified
set statusline+=%(%2*%m%*\ %)
" Filetype
set statusline+=%3*%y%*
" Switch to right
set statusline+=%=
" Line/Column
set statusline+=\ %l:%c
" Location
set statusline+=\ %P
" Space Buffer
set statusline+=\ 
