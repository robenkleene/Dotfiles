" vim:foldmethod=marker

" UI {{{1

" Show 80 character bar
set colorcolumn=80 

" Highlight cursor line
" set cursorline 
" Show cursorline only in active window
augroup cursor_line_active_window
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END
" Disable Cursor Line in Insert Mode
augroup disable_cursor_line
  autocmd!
  autocmd InsertEnter * set nocursorline
  autocmd InsertLeave * set cursorline
augroup END

" Fix quickfix colors
augroup quickfix_colors
  autocmd!
  " These interfere with quickfix highlighting
  autocmd BufWinEnter * if &buftype == 'quickfix' | setlocal nocursorline | endif
  autocmd BufWinEnter * if &buftype == 'quickfix' | setlocal colorcolumn="" | endif
augroup END

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
set statusline+=%{fnamemodify(getcwd(),':t')}\ 
" Truncate Marker
set statusline+=%<
" Filename
set statusline+=%-.30f
" Modified
set statusline+=%m 
" Filetype
set statusline+=\ %y
" Syntastic
if exists(':SyntasticStatuslineFlag')
  set statusline+=\ 
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  set statusline+=\ 
endif

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
