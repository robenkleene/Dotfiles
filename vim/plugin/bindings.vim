nnoremap Y yg_

nnoremap <localleader>yg :YankGrep<CR>
nnoremap <silent> <M-r> :silent !open -R "%:p"<CR>\|:redraw!<CR>
nnoremap <silent> <leader>yg :let @*=GrepLine()<CR>
