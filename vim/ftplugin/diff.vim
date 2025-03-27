setlocal readonly nomodifiable
setlocal foldlevel=2

" Matches `netrw` `p` to preview file
nnoremap <silent> <buffer> p <C-w>s:Gtdiff<CR>zz<C-w>p
nnoremap <silent> <buffer> <CR> <C-w>s:Gtdiff<CR>
