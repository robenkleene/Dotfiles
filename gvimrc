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
let s:bgcolor = 'gray12'
let s:backgroundgroups = ['CursorColumn', 'CursorLine', 
            \ 'NonText', 'SpecialKey', 'VertSplit',
            \ 'Normal', 'FoldColumn', 'SignColumn'] 
for group in s:backgroundgroups
    exe 'highlight ' . group . ' guibg=' . s:bgcolor
endfor
" Line Numbers
let s:gutterbgcolor = 'gray20'
let s:gutterfgcolor = 'DarkGray'
let s:gutterfgbggroups = ['LineNr', 'StatusLineNC']
let s:gutterbggroups = ['CursorLineNr', 'ColorColumn']
for group in s:gutterfgbggroups
    exe 'highlight ' . group . ' guibg=' . s:gutterbgcolor . ' guifg=' .  
                \ s:gutterfgcolor
endfor
for group in s:gutterbggroups
    exe 'highlight ' . group . ' guibg=' . s:gutterbgcolor
endfor
" Selection
" let s:selectionbgcolor= lightblue'

" Search
highlight Search guifg=black guibg=lightblue
" Wildmenu
highlight Wildmenu guifg=lightmagenta guibg=NONE
" StatusLine
highlight StatusLine guibg=Gray guifg=black
" NC StatusLine bg is gutter color
highlight StatusLineNC guifg=DarkGray
" Tildes
highlight NonText guifg=DarkGray
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
highlight GitGutterAddDefault guibg=NONE guifg=green
highlight GitGutterChangeDefault guibg=NONE guifg=lightblue
highlight GitGutterDeleteDefault guibg=NONE guifg=red
highlight GitGutterAddInvisible guibg=NONE guifg=green
highlight GitGutterChangeInvisible guibg=NONE guifg=lightblue
highlight GitGutterDeleteInvisible guibg=NONE guifg=red

" Key Commands {{{1
nnoremap <leader>sv :source $MYVIMRC<CR>:source $MYGVIMRC<CR>
