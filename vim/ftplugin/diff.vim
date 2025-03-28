setlocal readonly nomodifiable
setlocal foldlevel=2

" Matches `netrw` `p` to preview file
nnoremap <silent> <buffer> p :GtdPedit<CR>
nnoremap <silent> <buffer> <CR> :GtdEdit<CR>
