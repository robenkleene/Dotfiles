" Unsetting these lets `<M-p>` and '<M-n>` be bound
set <F32>&
set <F33>&

" This is set in RSI
" cnoremap <C-y> <C-r>*
cnoremap <expr> <C-y> getreg('*') ? "<C-r>*" : "<C-r>0" 
