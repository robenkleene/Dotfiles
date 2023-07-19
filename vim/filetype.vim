if exists("did_load_filetypes")
  finish
endif

augroup setup_filetype
  autocmd!
  au! BufRead,BufNewFile *.plist setfiletype xml
  au! BufRead,BufNewFile eslintrc setfiletype json
  au! BufRead,BufNewFile *.omnijs setfiletype javascript
augroup END
