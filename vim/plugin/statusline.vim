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
" Working Directory
set statusline+=%.40{pathshorten(fnamemodify(getcwd(win_getid()),':~'))}\ 
" Switch to right
set statusline+=%=
" Machine Name
set statusline+=%{strpart(getenv('SSH_CONNECTION')!=v:null?hostname().'\ ':'',0,14)}\ 
" set statusline+=%{hostname()}\ 
" Line/Column/Location
set statusline+=%l:%c\ %P
" Space Buffer
set statusline+=\ 
