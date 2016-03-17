" Color Scheme {{{1

" Notes for working with colors:
" `XtermColorTable` displays the hex colors a terminal equivalents
" `:so $VIMRUNTIME/syntax/colortest.vim` displays the named colors
" Or use my command `:RunColorTest`
" Colorscheme
set background=dark
colorscheme tir_black
" tir_black bug fixes
" For some reason "blue" display weird in console vim when it overlaps with the
" highlighted cursorline (test this by running `RunColorTest` and then going
" to the `blue` or `darkblue` lines. Changes these colors to another fixes
" this)
hi rubyControl ctermfg=lightblue
hi rubyInterpolationDelimiter ctermfg=lightblue

" Background {{{1
let s:bgcolor = 'NONE'
let s:backgroundgroups = ['CursorColumn', 
      \ 'NonText', 'SpecialKey', 'VertSplit',
      \ 'Normal', 'SignColumn', 'FoldColumn']
" Set Background Colors
for group in s:backgroundgroups
  exe 'highlight ' . group . ' ctermbg=' . s:bgcolor
endfor

" Line Numbers {{{1
highlight LineNr ctermbg=NONE ctermfg=237

" Cursor Line {{{1
let s:highlightbgcolor = '237'
let s:highlightfgcolor = 'NONE'

let s:highlightgroups = ['CursorLine', 'CursorLineNr']
for group in s:highlightgroups
  exe 'highlight ' . group . ' ctermbg=' . s:highlightbgcolor  . ' ctermfg=' .  
        \ s:highlightfgcolor
endfor

" Wild Menu {{{1
highlight Wildmenu ctermbg=lightcyan ctermfg=black

" Autocomplete {{{1
highlight Pmenu ctermfg=white ctermbg=242
highlight PmenuSel ctermfg=black ctermbg=lightcyan

" Visual Selection {{{1
" BG: #b2b2b2 FG: #585858
let s:selectionbgcolor = '242'
let s:selectionfgcolor = 'white'
let s:selectiongroups = ['Visual', 'MatchParen']
for group in s:selectiongroups
  exe 'highlight ' . group . ' ctermbg=' . s:selectionbgcolor  . ' ctermfg=' .  
        \ s:selectionfgcolor
endfor

" Search {{{1
highlight IncSearch cterm=underline ctermbg=NONE ctermfg=white
highlight Search cterm=underline ctermfg=white ctermbg=NONE

" Status Line {{{1
highlight StatusLine ctermbg=white ctermfg=243
highlight StatusLineNC ctermfg=239 ctermbg=250

" Mode Message {{{1

highlight ModeMsg ctermfg=white ctermbg=darkmagenta cterm=bold
" Tabs {{{1
highlight TabLine cterm=NONE ctermbg=238 ctermfg=249
highlight TabLineFill cterm=NONE ctermbg=238 ctermfg=249

" Column Guide {{{1
highlight ColorColumn ctermbg=237

" Warnings & Errors {{{1
highlight WarningMsg ctermfg=black ctermbg=yellow cterm=bold
highlight ErrorMsg ctermfg=white ctermbg=red cterm=bold
highlight SpellBad ctermfg=red ctermbg=NONE cterm=underline
highlight SpellCap ctermfg=yellow ctermbg=NONE cterm=underline

" Diff {{{1
highlight DiffAdd ctermfg=darkgreen ctermbg=NONE cterm=bold
highlight DiffAdded ctermfg=darkgreen ctermbg=NONE cterm=bold
highlight DiffDelete ctermfg=red ctermbg=NONE cterm=bold
highlight DiffRemoved ctermfg=red ctermbg=NONE cterm=bold
highlight DiffChange ctermfg=lightblue ctermbg=NONE cterm=bold
highlight DiffText ctermfg=lightblue ctermbg=NONE cterm=bold

" Comments & Tildes {{{1

highlight comment ctermfg=darkgray
highlight SpecialKey ctermfg=237
highlight NonText ctermfg=237


" Markdown {{{1

" Custom Syntax
" Colors
highlight markdownLinkText cterm=underline gui=underline
highlight markdownLinkText ctermfg=110
highlight markdownCode ctermfg=grey ctermbg=NONE
highlight markdownCodeBlock ctermfg=grey ctermbg=NONE
highlight markdownListMarker ctermfg=grey
highlight markdownItalic cterm=bold
highlight markdownBold cterm=bold

highlight markdownH1 ctermfg=229
highlight markdownH2 ctermfg=229
highlight markdownH3 ctermfg=229
highlight markdownH4 ctermfg=229
highlight markdownH5 ctermfg=229
highlight markdownH6 ctermfg=229

" Groups
highlight link markdownItalicDelimiter Comment
highlight link markdownBoldDelimiter Comment
highlight link markdownLinkText Keyword
highlight link markdownBlockquote Comment
highlight link markdownHeadingDelimiter Comment
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
highlight Folded ctermfg=250 ctermbg=239

" Plugins {{{1

" Git Gutter {{{2
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=lightblue
highlight GitGutterDelete ctermfg=red
highlight GitGutterAddDefault ctermbg=NONE ctermfg=green
highlight GitGutterChangeDefault ctermbg=NONE ctermfg=lightblue
highlight GitGutterDeleteDefault ctermbg=NONE ctermfg=red
highlight GitGutterAddInvisible ctermbg=NONE ctermfg=green
highlight GitGutterChangeInvisible ctermbg=NONE ctermfg=lightblue
highlight GitGutterDeleteInvisible ctermbg=NONE ctermfg=red

" Syntastic {{{2
highlight SyntasticErrorSign ctermfg=red
highlight SyntasticWarningSign ctermfg=yellow
highlight SyntasticStyleWarningSign ctermfg=yellow
" highlight SyntasticErrorLine ctermbg=red
