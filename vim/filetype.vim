if exists("did_load_filetypes")
  finish
endif

augroup setup_filetype
  autocmd!
  au! BufRead,BufNewFile *.conf setfiletype conf
  au! BufRead,BufNewFile *.m,*.h setfiletype objc
  au! BufRead,BufNewFile Fastfile setfiletype ruby
  au! BufRead,BufNewFile *.plist setfiletype xml
  au! BufRead,BufNewFile eslintrc setfiletype json
  au! BufRead,BufNewFile *.omnijs setfiletype javascript
augroup END
