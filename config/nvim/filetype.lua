vim.filetype.add({ extension = { omnijs = "javascript" } })
vim.filetype.add({ filename = { eslintrc = "json" } })
vim.filetype.add({ extension = { plist = "xml" } })
vim.cmd([[
augroup setup_filetype
  " Interpret `hg show` output as `diff`
  autocmd!
  au! StdinReadPost * if eval('@%') == '' && getline(1) =~ '^changeset:' | setfiletype diff | endif
augroup END
]])
