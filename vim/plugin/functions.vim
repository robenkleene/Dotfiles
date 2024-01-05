function! GrepLine() abort
  return expand("%:~").":".line('.')
endfunction

