if exists("did_load_filetypes")
  finish
endif

augroup setup_filetype
  autocmd!
  " Extensions
  autocmd BufRead,BufNewFile *.omnijs setfiletype javascript
  autocmd BufRead,BufNewFile *.m setfiletype objc
  autocmd BufRead,BufNewFile *.pde setfiletype java
  autocmd BufRead,BufNewFile *.plist setfiletype xml
  autocmd BufRead,BufNewFile *.opml setfiletype xml

  " Filename
  autocmd BufRead,BufNewFile Brewfile setfiletype conf
  autocmd BufRead,BufNewFile eslintrc setfiletype json
augroup END
