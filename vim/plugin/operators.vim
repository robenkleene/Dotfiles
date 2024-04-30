nnoremap <expr> gyg operators#YankGrep()
xnoremap <expr> gyg operators#YankGrep()
nnoremap <expr> gyggyg operators#YankGrep() .. '_'

nnoremap <expr> gyc operators#YankCodeBlock()
xnoremap <expr> gyc operators#YankCodeBlock()
nnoremap <expr> gycgyc operators#YankCodeBlock() .. '_'
