" UI {{{1

" Show 80 character bar
set colorcolumn=80

" Show line numbers
set number

" Highlight search results
set hlsearch

" Don't display search highlight on startup
nohlsearch

" Status Line {{{1
set laststatus=2
" Space Buffer
set statusline=\ 
" Working Directory
set statusline+=%.20{fnamemodify(getcwd(win_getid()),':~')}\ 
" Truncate Marker
set statusline+=%<
" Filename
" set statusline+=%.40f
" set statusline+=%.40{pathshorten(expand('%:~:.'))}
set statusline+=%.40{expand('%:~:.')}
" Modified
set statusline+=%m 
" Filetype
set statusline+=\ %y
" Switch to right
set statusline+=%=
" Line
set statusline+=L%l
" Column
set statusline+=\ C%c
" Location
set statusline+=\ %P
" Git status
if exists(':fugitive')
  set statusline+=\ %{fugitive#statusline()}
endif
" Space Buffer
set statusline+=\ 
