nnoremap Y yg_

nnoremap <localleader>yg :YankGrep<CR>
nnoremap <silent> <M-r> :silent !open -R "%:p"<CR>\|:redraw!<CR>

" Paste
snoremap <localleader>p :Cwise<CR>"0p
nnoremap <localleader>p :Cwise<CR>"0p
vnoremap <localleader>p :<C-u>Cwise<CR>gv"0p
snoremap <localleader>P :Cwise<CR>"0P
nnoremap <localleader>P :Cwise<CR>"0P
vnoremap <localleader>P :<C-u>Cwise<CR>gv"0P
