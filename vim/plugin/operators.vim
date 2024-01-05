nnoremap <expr> <localleader>yg operators#GrepYank()
xnoremap <expr> <localleader>yg operators#GrepYank()
nnoremap <expr> <localleader>yg<localleader>yg operators#GrepYank() .. '_'
