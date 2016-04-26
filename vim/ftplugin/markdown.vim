" General
let g:markdown_folding = 1
set nofoldenable
setlocal spell
set wrap

nnoremap <localleader>p :!open -a "Marked 2.app" "%:p"<CR>\|:redraw!<CR>

" Follow file links
" Search for `](` go right twice and then `gf`, etc...
nnoremap <buffer> <CR> ^/](<CR>2lgf
nnoremap <buffer> <C-w><CR> ^/](<CR>2l<C-w>f
nnoremap <buffer> <C-w>g<CR> ^/](<CR>2l<C-w>gf
