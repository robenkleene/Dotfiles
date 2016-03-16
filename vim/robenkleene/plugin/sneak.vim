let g:sneak#streak = 1

" Don't map bindings in `after` because this prevents sneak from mapping its
" own bindings when loading
nmap <leader>s <Plug>Sneak_s
nmap <leader>S <Plug>Sneak_S
vmap <leader>s <Plug>Sneak_s
vmap <leader>S <Plug>Sneak_S
