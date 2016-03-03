if exists("did_load_filetypes")
  finish
endif

augroup setup_filetype
  autocmd!
  au! BufRead,BufNewFile *.m setfiletype objc
augroup END
