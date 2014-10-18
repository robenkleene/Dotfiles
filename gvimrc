" vim:fdm=marker
" General
:set macmeta

" Window
set guioptions-=T " Disable toolbar
set guioptions-=L " Disable left scroll bar with vertical splits
set guioptions-=r " Disable right scrollbar
" Size
" set lines=48 " Rows
set lines=24 " Rows
set columns=80 " Columns

" Look & Feel
" colorscheme ir_black_edited
colorscheme ir_black
set background=dark

set guifont=Menlo\ Regular:h12 " Set font
set gcr=a:blinkon0 " Disable Cursor blinking
" set transparency=5
" highlight Normal guibg=#1b212c

" set noantialias " No anti-aliasing sometimes looks better
" syntax enable
" Solarized
" set background=dark
" set background=light
" colorscheme solarized

" Remove backgrounds
highlight LineNr guibg=NONE
highlight SpecialKey guibg=NONE
highlight NonText guibg=NONE
highlight VertSplit guibg=NONE
highlight FoldColumn guibg=NONE
highlight SignColumn guibg=NONE
highlight SignColumn guibg=NONE
highlight CursorColumn guibg=NONE
highlight CursorLine guibg=NONE
highlight ColorColumn guibg=NONE
highlight CursorColumn guibg=NONE
highlight CursorLine guibg=NONE
highlight ColorColumn guibg=NONE

" StatusLine
highlight StatusLine guibg=darkgray guifg=black

" Search
highlight Search guifg=lightmagenta

" Diff Colors
highlight DiffAdd guifg=green guibg=darkgreen
highlight DiffDelete guifg=red guibg=darkred
highlight DiffChange guibg=darkcyan
highlight DiffText guifg=lightblue guibg=darkblue

