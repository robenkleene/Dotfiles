" command! Marked silent !open -a "Marked.app" "%:p"
" nmap <silent> <leader>p :Marked<CR>\|:redraw!<CR>
command! MarkdownPreview !mdprev -m "%:p"
nmap <silent> <leader>p :MarkdownPreview<CR>\|:redraw!<CR>

" OS X Shortcut Special Characters
command! InsertShortcutSymbols :normal i⇧⌃⌥⌘<ESC>
nmap <leader>s :InsertShortcutSymbols<CR>
