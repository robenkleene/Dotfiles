nnoremap <expr> gym operators#YankMarkdown()
xnoremap <expr> gym operators#YankMarkdown()
nnoremap <expr> gymm operators#YankMarkdown({}, '', 1) .. '_'
nnoremap <expr> gymM operators#YankMarkdown({}, '', 1, 1) .. '_'
