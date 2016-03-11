" Color Scheme {{{1
colorscheme ir_black
set background=dark

" Background {{{1
" let s:bgcolor = 'gray15'
let s:bgcolor = '#232323'
" let s:bgcolor = '#0E032B'
let s:backgroundgroups = ['CursorColumn', 'LineNr',
            \ 'NonText', 'SpecialKey', 'VertSplit',
            \ 'Normal', 'FoldColumn', 'SignColumn'] 
for group in s:backgroundgroups
    exe 'highlight ' . group . ' guibg=' . s:bgcolor
endfor

" Line Numbers {{{1
highlight LineNr guifg=#7c7c7c

" Wild Menu {{{1
highlight Wildmenu guibg=lightcyan guifg=black

" Autocomplete {{{1
highlight Pmenu guifg=white guibg=#7c7c7c
highlight PmenuSel guifg=black guibg=lightcyan

" Cursor Line {{{1
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

" Visual Selection {{{1
let s:selectionbgcolor = '#7c7c7c'
let s:selectionfgcolor = 'white'
let s:selectiongroups = ['Visual', 'MatchParen']
for group in s:selectiongroups
    exe 'highlight ' . group . ' guibg=' . s:selectionbgcolor  . ' guifg=' .  
                \ s:selectionfgcolor
endfor

" Search {{{1
highlight IncSearch gui=underline guifg=white guibg=NONE
highlight Search gui=underline guifg=white guibg=NONE

" StatusLine {{{1
highlight StatusLine guibg=#7c7c7c guifg=white gui=NONE
highlight StatusLineNC guifg=#7c7c7c guibg=#333333

" Tabs {{{1
highlight TabLine gui=NONE guifg=#7c7c7c guibg=#333333
highlight TabLineFill gui=NONE guifg=#7c7c7c guibg=#333333

" Column Guide {{{1
highlight ColorColumn guibg=gray20
" Tildes {{{1
highlight NonText guifg=DarkGray

" Warning Message {{{1
highlight WarningMsg guifg=white guibg=red gui=bold

" Diff {{{1
highlight DiffAdd gui=NONE guifg=green guibg=darkgreen
highlight DiffDelete gui=NONE guifg=red guibg=darkred
highlight DiffChange gui=NONE guifg=NONE guibg=NONE
highlight DiffText gui=NONE guifg=lightblue guibg=darkblue

" Markdown {{{1
highlight markdownLinkText gui=underline
highlight markdownLinkText guifg=lightblue
highlight markdownCode guibg=NONE guifg=DarkGray
highlight markdownCodeBlock guibg=NONE guifg=DarkGray
highlight markdownItalic gui=italic
highlight markdownH1 guifg=#ffffb6
highlight markdownH2 guifg=#ffffb6
highlight markdownH3 guifg=#ffffb6
highlight markdownH4 guifg=#ffffb6
highlight markdownH5 guifg=#ffffb6
highlight markdownH6 guifg=#ffffb6
" Groups
highlight link markdownItalicDelimiter Comment
highlight link markdownBoldDelimiter Comment
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

" Folding {{{1
" Same as inactive status line
highlight Folded guifg=#7c7c7c guibg=#333333

" Plugins {{{1

" Git Gutter {{{2
highlight GitGutterAdd guifg=green
highlight GitGutterChange guifg=lightblue
highlight GitGutterDelete guifg=red
highlight GitGutterAddDefault guibg=NONE guifg=green
highlight GitGutterChangeDefault guibg=NONE guifg=lightblue
highlight GitGutterDeleteDefault guibg=NONE guifg=red
highlight GitGutterAddInvisible guibg=NONE guifg=green
highlight GitGutterChangeInvisible guibg=NONE guifg=lightblue
highlight GitGutterDeleteInvisible guibg=NONE guifg=red

" Syntastic Colors {{{2
highlight SyntasticErrorSign guifg=red
highlight SyntasticWarningSign guifg=yellow
highlight SyntasticStyleWarningSign guifg=yellow
" highlight SyntasticErrorLine guibg=red
