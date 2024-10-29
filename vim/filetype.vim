if exists("did_load_filetypes")
  finish
endif

augroup setup_filetype
  autocmd!
  au! BufRead,BufNewFile *.plist setfiletype xml
  au! BufRead,BufNewFile eslintrc setfiletype json
  au! BufRead,BufNewFile *.omnijs setfiletype javascript
  au! BufRead,BufNewFile *.pde setfiletype java
  " Interpret `hg show` output as `diff`
  au! StdinReadPost * if eval('@%') == '' && &buftype == '' && getline(1) =~ '^changeset:' | setfiletype diff | endif
  au! BufRead,BufNewFile Brewfile setfiletype conf
augroup END
