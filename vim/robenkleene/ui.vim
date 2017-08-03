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
function! MyNeomakeStatus() abort
  if !exists('*neomake#statusline#LoclistCounts')
    return ''
  endif
  " Count all the errors, warnings
  let total = 0
  for value in values(neomake#statusline#LoclistCounts())
    let total += value
  endfor
  for value in items(neomake#statusline#QflistCounts())
    let total += value
  endfor
  if total == 0
    return ''
  endif
  return 'E' . total . ' '
endfunction

" GitGutter
set statusline+=%{MyGitGutterStatus()}
function! MyGitGutterStatus() abort
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
