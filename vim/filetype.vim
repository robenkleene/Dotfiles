if exists("did_load_filetypes")
  finish
endif

augroup setup_filetype
  autocmd!
  " Extensions
  autocmd! BufRead,BufNewFile *.omnijs setfiletype javascript
  autocmd! BufRead,BufNewFile *.m setfiletype objc
  autocmd! BufRead,BufNewFile *.pde setfiletype java
  autocmd! BufRead,BufNewFile *.plist setfiletype xml
  autocmd! BufRead,BufNewFile *.opml setfiletype xml

  " Filename
  autocmd! BufRead,BufNewFile Brewfile setfiletype conf
  autocmd! BufRead,BufNewFile eslintrc setfiletype json

  " Mercurial
  " Interpret `hg show` output as `diff`
  " au! StdinReadPost * if eval('@%') == '' && &buftype == '' && getline(1) =~ '^changeset:' | setfiletype diff | endif
  " Make `hg` output be `readonly` and `nofile` to work better as a `hg log`
  " viewer
  autocmd! BufEnter * if eval('@%') == ''
        \ && &buftype == ''
        \ && getline(1) =~ '^o  [a-z0-9]\{10}'
        \ && getline(2) =~ '^╷$'
        \ | setlocal buftype=nofile readonly nomodifiable
        \ | endif
augroup END
