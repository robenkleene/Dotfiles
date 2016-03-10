" Normalizing Movement Key Commands {{{1

" Kill line
inoremap <C-k> <C-O>d$
cnoremap <C-K> <C-\>e<SID>KillLine()<CR>
function! s:KillLine()
  let l:cmd = getcmdline()
  let l:rem = strpart(l:cmd, getcmdpos() - 1)
  if ('' != l:rem)
    let @c = l:rem
  endif
  let l:ret = strpart(l:cmd, 0, getcmdpos() - 1)
  return l:ret
endfunction




