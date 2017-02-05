" UI {{{1

" Show 80 character bar
set colorcolumn=80

" Highlight cursor line
" set cursorline
" Show cursorline only in active window
augroup cursor_line_active_window
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  " Don't leave disable nocursorline, otherwise the current line won't be 
  " highlighted when using the `quickfix` list
  " autocmd WinLeave * setlocal nocursorline
augroup END

" Disable Cursor Line in Insert Mode
augroup disable_cursor_line
  autocmd!
  autocmd InsertEnter * setlocal nocursorline
  autocmd InsertLeave * setlocal cursorline
augroup END

" Fix quickfix colors
augroup quickfix_colors
  autocmd!
  " These interfere with quickfix highlighting
  autocmd VimEnter,WinEnter,BufWinEnter * if &buftype == 'quickfix' | setlocal nocursorline | endif
  autocmd WinEnter,BufWinEnter * if &buftype == 'quickfix' | setlocal colorcolumn="" | endif
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
set statusline+=%.20{fnamemodify(getcwd(),':~')}\ 
" Truncate Marker
set statusline+=%<
" Filename
set statusline+=%.40f
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

" Neomake
set statusline+=%{MyNeomakeStatus()}
function! MyNeomakeStatus()
  if !exists('*neomake#statusline#LoclistCounts')
    return ''
  endif
  " Count all the errors, warnings
  let total = 0
  for s:v in values(neomake#statusline#LoclistCounts())
    let total += s:v
  endfor
  for s:v in items(neomake#statusline#QflistCounts())
    let total += s:v
  endfor
  if total == 0
    return ''
  endif
  unlet s:v
  return 'E' . total . ' '
endfunction

" GitGutter
set statusline+=%{MyGitGutterStatus()}
function! MyGitGutterStatus()
  if !exists('*GitGutterGetHunkSummary')
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added,
        \ g:gitgutter_sign_modified,
        \ g:gitgutter_sign_removed
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  if len(ret) == 0
    return ''
  endif
  return join(ret, ' ') .  ' '
endfunction

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
