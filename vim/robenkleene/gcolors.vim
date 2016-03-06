" Graphic Colors {{{1

" Color Scheme {{{2
colorscheme ir_black
set background=dark

" Background {{{2
" let s:bgcolor = 'gray15'
let s:bgcolor = '#232323'
" let s:bgcolor = '#0E032B'
let s:backgroundgroups = ['CursorColumn', 'LineNr',
            \ 'NonText', 'SpecialKey', 'VertSplit',
            \ 'Normal', 'FoldColumn', 'SignColumn'] 
for group in s:backgroundgroups
    exe 'highlight ' . group . ' guibg=' . s:bgcolor
endfor

" Line Numbers {{{2
highlight LineNr guifg=#7c7c7c

" Cursor Line {{{2
let s:gutterbgcolor = 'gray20'
let s:gutterfgcolor = 'DarkGray'
let s:gutterfgbggroups = ['StatusLineNC']
let s:gutterbggroups = ['CursorLine']
for group in s:gutterfgbggroups
  exe 'highlight ' . group . ' guibg=' . s:gutterbgcolor . ' guifg=' .  
        \ s:gutterfgcolor
endfor
highlight CursorLineNr guifg=NONE guibg=gray20
for group in s:gutterbggroups
  exe 'highlight ' . group . ' guibg=' . s:gutterbgcolor
endfor

" Visual Selection {{{2
let s:selectionbgcolor = 'lightblue'
let s:selectionfgcolor = 'black'
let s:selectiongroups = ['Search', 'Wildmenu']
for group in s:selectiongroups
    exe 'highlight ' . group . ' guibg=' . s:selectionbgcolor  . ' guifg=' .  
                \ s:selectionfgcolor
endfor
highlight Visual guifg=white guibg=darkcyan

" Search {{{2
highlight IncSearch gui=underline guifg=white guibg=NONE
highlight Search gui=underline guifg=white guibg=NONE

" StatusLine {{{2
highlight StatusLine guibg=#7c7c7c guifg=white gui=NONE
highlight StatusLineNC guifg=#7c7c7c guibg=#333333

" Tabs {{{2
highlight TabLine gui=NONE guifg=#7c7c7c guibg=#333333
highlight TabLineFill gui=NONE guifg=#7c7c7c guibg=#333333

" Column Guide {{{2
highlight ColorColumn guibg=gray20
" Tildes {{{2
highlight NonText guifg=DarkGray

" Warning Message {{{2
highlight WarningMsg guifg=white guibg=red gui=bold

" Diff {{{2
highlight DiffAdd gui=NONE guifg=green guibg=darkgreen
highlight DiffDelete gui=NONE guifg=red guibg=darkred
highlight DiffChange gui=NONE guifg=NONE guibg=NONE
highlight DiffText gui=NONE guifg=lightblue guibg=darkblue

" Folding {{{2
" Same as inactive status line
highlight Folded guifg=#7c7c7c guibg=#333333

" Plugins {{{2

" Git Gutter {{{3
highlight GitGutterAdd guifg=green
highlight GitGutterChange guifg=lightblue
highlight GitGutterDelete guifg=red
highlight GitGutterAddDefault guibg=NONE guifg=green
highlight GitGutterChangeDefault guibg=NONE guifg=lightblue
highlight GitGutterDeleteDefault guibg=NONE guifg=red
highlight GitGutterAddInvisible guibg=NONE guifg=green
highlight GitGutterChangeInvisible guibg=NONE guifg=lightblue
highlight GitGutterDeleteInvisible guibg=NONE guifg=red

" Syntastic Colors {{{3
highlight SyntasticErrorSign guifg=red
highlight SyntasticWarningSign guifg=yellow
highlight SyntasticStyleWarningSign guifg=yellow
" highlight SyntasticErrorLine guibg=red
