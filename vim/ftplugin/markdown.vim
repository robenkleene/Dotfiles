" command! Marked silent !open -a "Marked.app" "%:p"
" nmap <silent> <leader>p :Marked<CR>\|:redraw!<CR>
command! MarkdownPreview !mdprev "%:p"
nmap <silent> <leader>p :MarkdownPreview<CR>\|:redraw!<CR>

" OS X Shortcut Special Characters
command! InsertShortcutSymbols :normal i⇧⌃⌥⌘<ESC>
nmap <leader>s :InsertShortcutSymbols<CR>

" Create list item from clipboard
:command ListItemFromClipboard :normal o<esc>pI- <ESC>
nmap <leader>l :ListItemFromClipboard<CR>
