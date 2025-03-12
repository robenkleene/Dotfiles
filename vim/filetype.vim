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

  " Filename
  au! BufRead,BufNewFile Brewfile setfiletype conf
  au! BufRead,BufNewFile eslintrc setfiletype json

  " Special
  " Interpret `hg show` output as `diff`
  " This isn't always working, probably better just to use `hg diff -c .`
  au! StdinReadPost * if eval('@%') == '' && &buftype == '' && getline(1) =~ '^changeset:' | setfiletype diff | endif
augroup END
