" General
let g:markdown_folding = 1
set nofoldenable
setlocal spell
set wrap

" Don't show 80 character guide
setlocal colorcolumn=""

nnoremap <localleader>p :!open -a "Marked 2.app" "%:p"<CR>\|:redraw!<CR>

" Follow file links
" Search for `](` go right twice and then `gf`, etc...
" TODO: This really should be made to only work with file URLs and relative
" files. Right now it also works with regular URLs which causes Netrw to curl
" the web page and open it in a temporary buffer.
nnoremap <buffer> <CR> ^/](<CR>2lgf
nnoremap <buffer> <C-w><CR> ^/](<CR>2l<C-w>f
nnoremap <buffer> <C-w>g<CR> ^/](<CR>2l<C-w>gf
