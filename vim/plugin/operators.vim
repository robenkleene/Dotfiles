nnoremap <expr> gyg operators#YankGrep()
xnoremap <expr> gyg operators#YankGrep()
nnoremap <expr> gygg operators#YankGrep() .. '_'

nnoremap <expr> gyc operators#YankCodeBlock()
xnoremap <expr> gyc operators#YankCodeBlock()
nnoremap <expr> gycc operators#YankCodeBlock() .. '_'
