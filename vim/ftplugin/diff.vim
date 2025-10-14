setlocal foldlevel=2

" If `eval('@%')` is empty, than this isn't backed by a file
" Setting `buftype=nofile readonly nomodifiable` makes it easier to use diffs
" generated from commands as a diff viewer
if eval('@%') == ''
  setlocal buftype=nofile readonly nomodifiable
end

" Matches `netrw` `p` to preview file
nnoremap <silent> <buffer> p :GtdPedit<CR>
" Matches `netrw` `<CR>` to open files
nnoremap <silent> <buffer> <CR> :GtdEdit<CR>
