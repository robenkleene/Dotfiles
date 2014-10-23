" vim:fdm=marker
" General
let g:markdown_folding = 1
set nofoldenable
setlocal spell
" set foldlevel=1

" Commands

" Markdown Preview
" command! MarkdownPreview :execute '!mdprev '.shellescape(expand('%:p'), 1)
" nnoremap <silent> <leader>p :MarkdownPreview<CR>\|:redraw!<CR>

" OS X Shortcut Special Characters
" command! InsertShortcutSymbols :normal i⇧⌃⌥⌘<ESC>
" nnoremap <leader>s :InsertShortcutSymbols<CR>

" Quoting Lines
" :command! LineToQuote :normal I> <ESC>
" nnoremap <leader>q :LineToQuote<CR>

" Creating List Items
" Create list item from clipboard
" :command! ListItemFromClipboard :normal o<esc>pI- <ESC>
" nnoremap <leader>v :ListItemFromClipboard<CR>
" Line to list item
" :command! LineToListItem :normal I- <ESC>
" nnoremap <leader>l :LineToListItem<CR>

" Creating Headers
" :command! Header1 :normal O<esc>O# <esc>
" nnoremap <leader>1 :Header1<CR>:startinsert!<CR>
" :command! Header2 :normal O<esc>O## <esc>
" nnoremap <leader>2 :Header2<CR>:startinsert!<CR>
" :command! Header3 :normal O<esc>O### <esc>
" nnoremap <leader>3 :Header3<CR>:startinsert!<CR>

" Custom Syntax
" Colors
highlight markdownLinkText cterm=underline gui=underline
highlight markdownLinkText guifg=lightblue
highlight markdownLinkText ctermfg=lightblue
highlight markdownCode guibg=gray20 guifg=DarkGray
highlight markdownCode ctermfg=lightgray ctermbg=darkgray
highlight markdownCodeBlock guibg=gray20 guifg=DarkGray
highlight markdownCodeBlock ctermfg=lightgray ctermbg=darkgray
highlight markdownItalic ctermbg=NONE cterm=italic ctermfg=NONE term=italic

" Groups
highlight link markdownLinkText Keyword
highlight link markdownBlockquote Comment
highlight link markdownHeadingDelimiter Comment
highlight link markdownListMarker Comment
highlight link markdownCodeDelimiter Comment
highlight link markdownLinkTextDelimiter Comment
highlight link markdownLinkDelimiter Comment
highlight link markdownUrl Comment
highlight link markdownH1 String
highlight link markdownH2 String
highlight link markdownH3 String
highlight link markdownH4 String
highlight link markdownH5 String
highlight link markdownH6 String
