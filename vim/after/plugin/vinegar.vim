" Hack to fix selecting the current file in `vinegar` by replacing `opendir`
" `edit` with `Explore`
" nnoremap <silent> <expr> - (&filetype ==# 'netrw' ? '<Plug>VinegarUp' : ':call <SID>opendir(\'Explore\')<CR>')
nnoremap <silent> <expr> - (&filetype ==# 'netrw' ? '<Plug>VinegarUp' : ':call <SID>opendir("Explore")<CR>')
let s:dotfiles = '\(^\|\s\s\)\zs\.\S\+'
function! s:opendir(cmd) abort
  let df = ','.s:dotfiles
  if expand('%:t')[0] ==# '.' && g:netrw_list_hide[-strlen(df):-1] ==# df
    let g:netrw_list_hide = g:netrw_list_hide[0 : -strlen(df)-1]
  endif
  if &filetype ==# 'netrw' && len(s:netrw_up)
    let basename = fnamemodify(b:netrw_curdir, ':t')
    execute s:netrw_up
    call s:seek(basename)
  elseif expand('%') =~# '^$\|^term:[\/][\/]'
    execute a:cmd '.'
  else
    execute a:cmd '%:h' . (expand('%:p') =~# '^\a\a\+:' ? s:slash() : '')
    call s:seek(expand('#:t'))
  endif
endfunction
function! s:seek(file) abort
  if get(b:, 'netrw_liststyle') == 2
    let pattern = '\%(^\|\s\+\)\zs'.escape(a:file, '.*[]~\').'[/*|@=]\=\%($\|\s\+\)'
  else
    let pattern = '^\%(| \)*'.escape(a:file, '.*[]~\').'[/*|@=]\=\%($\|\t\)'
  endif
  call search(pattern, 'wc')
  return pattern
endfunction
function! s:slash() abort
  return !exists("+shellslash") || &shellslash ? '/' : '\'
endfunction
