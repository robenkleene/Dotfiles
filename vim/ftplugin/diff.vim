setlocal foldexpr=DiffFold(v:lnum)
setlocal foldmethod=expr
" Set starting fold level
setlocal foldlevel=2
" Allow quickly quitting without saving when piping a diff to vim
" Handled as default now
" setlocal buftype=nofile

" Useful for debugging
setlocal foldcolumn=3
setlocal foldenable

nnoremap <buffer> gd :OpenDiff<CR>

function! DiffFold(lnum)
  let line = getline(a:lnum)
  if line =~ '^diff'
    return '>1'
  elseif line =~ '^@@'
    return '>2'
  else
    return '='
  endif
endfunction
command! OpenDiff :call <SID>OpenDiff()
function! s:OpenDiff() abort
  let l:grep = system('~/.bin/filter_diff_to_grep '.line('.').' | tail -n1 | cut -d: -f1,2', join(getline(1,'$'), "\n"))
  let l:parts = split(l:grep, ':')
  exec "edit " . fnameescape(l:parts[0])
  let l:destlnum = l:parts[1]
  exec l:destlnum
endfunction
