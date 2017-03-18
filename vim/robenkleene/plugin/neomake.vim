augroup neomake_run
  autocmd!
  " Use `YouCompleteMe` for some file types
  " let s:ftToIgnore = ['objc', 'c']
  " autocmd BufReadPost,BufWritePost * if index(s:ftToIgnore, &ft) < 0 | Neomake
  autocmd BufReadPost,BufWritePost * Neomake
augroup END
