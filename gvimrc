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
let s:bgcolor='gray12'
" Built-in
let s:backgroundgroups = ['CursorColumn', 'CursorLine', 
            \ 'NonText', 'SpecialKey', 'VertSplit',
            \ 'Normal', 'FoldColumn', 'SignColumn'] 
" Set Background Colors
for group in s:backgroundgroups
    exe 'highlight ' . group . ' guibg=' . s:bgcolor
endfor
" Line Numbers
let s:guttercolor='gray20'
" Built-in
let s:guttergroups = ['LineNr', 'CursorLineNr']
" Git Gutter
" let guttergroups += ['GitGutterAdd', 'GitGutterChange', 'GitGutterDelete']
for group in s:guttergroups
    exe 'highlight ' . group . ' guibg=' . s:guttercolor
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
highlight DiffAdd gui=NONE guifg=green guibg=darkgreen
highlight DiffDelete gui=NONE guifg=red guibg=darkred
highlight DiffChange gui=NONE guifg=NONE guibg=NONE
highlight DiffText gui=NONE guifg=lightblue guibg=darkblue
" highlight DiffChange gui=NONE guifg=brown guibg=yellow
" highlight DiffText gui=NONE guifg=lightblue guibg=darkblue
" Git Gutter Colors
highlight GitGutterAdd guifg=green
highlight GitGutterChange guifg=lightblue
highlight GitGutterDelete guifg=red

" Key Commands {{{1
nnoremap <leader>sv :source $MYVIMRC<CR>:source $MYGVIMRC<CR>
