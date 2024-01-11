nnoremap Y yg_

nnoremap <silent> <M-r> :silent !open -R "%:p"<CR>\|:redraw!<CR>
nnoremap <silent> <leader>yg :let @*=GrepLine()<CR>:silent call system('~/.bin/safecopy -s',getreg('*'))<CR>
