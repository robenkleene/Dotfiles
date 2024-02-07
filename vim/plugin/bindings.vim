nnoremap Y yg_

nnoremap <silent> <leader>yg :let @*=GrepLine()<CR>:silent call system('~/.bin/safecopy -s',getreg('*'))<CR>
