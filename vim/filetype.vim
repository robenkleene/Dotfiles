if exists("did_load_filetypes")
  finish
endif

augroup setup_filetype
  autocmd!
  " Extensions
  au! BufRead,BufNewFile *.omnijs setfiletype javascript
  au! BufRead,BufNewFile *.m setfiletype objc
  au! BufRead,BufNewFile *.pde setfiletype java
  au! BufRead,BufNewFile *.plist setfiletype xml
  au! BufRead,BufNewFile *.opml setfiletype xml

  " Filename
  au! BufRead,BufNewFile Brewfile setfiletype conf
  au! BufRead,BufNewFile eslintrc setfiletype json

  " Mercurial
  " Interpret `hg show` output as `diff`
  au! StdinReadPost * if eval('@%') == '' && &buftype == '' && getline(1) =~ '^changeset:' | setfiletype diff | endif
  " Make `hg` output be `readonly` and `nofile` to work better as a `hg log`
  " viewer
  au! StdinReadPost * if eval('@%') == '' && &buftype == '' && \
    getline(1) =~ '^o  [a-z0-9]\{10}' && getline(2) =~ '^╷$' | \
    setlocal buftype=nofile readonly nomodifiable | endif
augroup END
