" Must be defined after `vim.rsi`
inoremap <expr><C-f> pumvisible() ? deoplete#close_popup() : "\<right>"
