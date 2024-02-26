" Space Buffer
set statusline=\ 
" Working Directory
set statusline+=%#netrwDir#%.40{pathshorten(fnamemodify(getcwd(win_getid()),':~'))}%*\ 
" Machine Name
" set statusline+=%#WarningMsg#%{getenv('SSH_CONNECTION')!=v:null?hostname().'\ ':''}%*
set statusline+=%#WarningMsg#%{hostname()}\ %*
" Truncate Marker
set statusline+=%<
" Filename
set statusline+=%(%.40{&filetype=='netrw'?b:netrw_curdir:(expand('%:t')!=''?expand('%:t'):'[No\ Name]')}\ %)
" %m: Modified
set statusline+=%(%#WarningMsg#%m%*\ %)
" %r: Read-only mode
set statusline+=%(%#WarningMsg#%r%*\ %)
" %h: Read-only
set statusline+=%(%#WarningMsg#%h%*\ %)
" Filetype
set statusline+=%y
" Switch to right
set statusline+=%=
" Line/Column/Location
" set statusline+=\ %#ModeMsg#\ %l:%c\ %P\ %*
set statusline+=\ %l:%c\ %P
" Space Buffer
set statusline+=\ 
