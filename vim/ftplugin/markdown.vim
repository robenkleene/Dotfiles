" command! Marked silent !open -a "Marked.app" "%:p"
" nmap <silent> <leader>p :Marked<CR>\|:redraw!<CR>

command! MarkdownPreview !mdprev -m "%:p"
nmap <silent> <leader>p :MarkdownPreview<CR>\|:redraw!<CR>
