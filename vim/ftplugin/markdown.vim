command! Marked silent !open -a "Marked.app" "%:p"
nmap <silent> <leader>p :Marked<CR>\|:redraw!<CR>
