" vim:foldmethod=marker

" General {{{1
set macmeta


" Look & Feel {{{1

" Window
set guioptions-=T " Disable toolbar
set guioptions-=L " Disable left scroll bar with vertical splits
set guioptions-=r " Disable right scrollbar
" Size
set lines=48 " Rows
set columns=80 " Columns
" Fonts
set guifont=Menlo\ Regular:h12 " Set font
set gcr=a:blinkon0 " Disable Cursor blinking
" set noantialias " No anti-aliasing sometimes looks better
" set transparency=5


" Colors {{{1

" Color Scheme
colorscheme ir_black
set background=dark
" Background
let bgcolor='gray12'
let backgroundgroups = ['CursorColumn', 'CursorLine', 
            \ 'NonText', 'SpecialKey', 'VertSplit',
            \ 'Normal'] 
for group in backgroundgroups
    exe 'highlight ' . group . ' guibg=' . bgcolor
endfor
" Line Numbers
let guttercolor='gray20'
let guttergroups = ['LineNr', 'SignColumn', 'FoldColumn', 'CursorLineNr']
for group in guttergroups
    exe 'highlight ' . group . ' guibg=' . guttercolor
endfor
highlight LineNr guifg=DarkGray
" StatusLine
highlight StatusLine guibg=Gray guifg=black
highlight StatusLineNC guibg=gray30 guifg=DarkGray
" Tildes
highlight  NonText guifg=DarkGray
" ColorColumn
highlight ColorColumn guibg=gray15
" Search
highlight Search guifg=lightmagenta
" Diff 
highlight DiffAdd guifg=green guibg=darkgreen
highlight DiffDelete guifg=red guibg=darkred
highlight DiffChange guibg=darkcyan
highlight DiffText guifg=lightblue guibg=darkblue

" Key Commands {{{1
nnoremap <leader>sv :source $MYVIMRC<CR>:source $MYGVIMRC<CR>
