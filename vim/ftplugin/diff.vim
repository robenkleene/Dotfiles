setlocal readonly nomodifiable
setlocal foldlevel=2

" Matches `netrw` `p` to preview file
nnoremap <silent> <buffer> p :GtdPedit<CR>
" Matches `netrw` `<CR>` to open files
nnoremap <silent> <buffer> <CR> :GtdEdit<CR>
