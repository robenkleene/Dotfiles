" Color Scheme {{{1

" Notes for working with colors:
" `XtermColorTable` displays the hex colors a terminal equivalents
" `:so $VIMRUNTIME/syntax/colortest.vim` displays the named colors
" Or use my command `:RunColorTest`
" `:so $VIMRUNTIME/syntax/hitest.vim` lists all the styled syntax groups
" Or use my command `:RunHighlightTest`

" Colorscheme
set background=dark
colorscheme tir_black
" tir_black bug fixes
" For some reason "blue" display weird in console vim when it overlaps with the
" highlighted cursorline (test this by running `RunColorTest` and then going
" to the `blue` or `darkblue` lines. Changes these colors to another fixes
" this)
highlight rubyControl ctermfg=lightblue
highlight rubyInterpolationDelimiter ctermfg=lightblue

" Background {{{1
let s:bgcolor = 'NONE'
let s:backgroundgroups = [
      \ 'NonText', 'SpecialKey', 'VertSplit',
      \ 'Normal', 'SignColumn', 'FoldColumn']
" Set Background Colors
for group in s:backgroundgroups
  exe 'highlight ' . group . ' ctermbg=' . s:bgcolor
endfor

" Line Numbers {{{1
highlight LineNr ctermbg=NONE ctermfg=238

" Cursor Line {{{1
let s:highlightbgcolor = '237'
let s:highlightfgcolor = 'NONE'

let s:highlightgroups = ['CursorLine', 'CursorLineNr', 'CursorColumn']
for group in s:highlightgroups
  exe 'highlight ' . group . ' ctermbg=' . s:highlightbgcolor  . ' ctermfg=' .  
        \ s:highlightfgcolor
endfor

" Wild Menu {{{1
highlight Wildmenu cterm=bold ctermbg=cyan ctermfg=black

" Autocomplete {{{1
highlight Pmenu ctermfg=white ctermbg=244
highlight PmenuSel ctermfg=black ctermbg=cyan

" Visual Selection {{{1
" Visual selection is distinguished from `Search` because a match can either
" be selected or not selected, so this difference in colors distinguishes
" that.
highlight Visual ctermbg=cyan ctermfg=black
" Original idea, grey background:
" highlight MatchParen ctermfg=white ctermbg=244
highlight MatchParen ctermfg=cyan ctermbg=NONE cterm=underline
highlight Todo ctermfg=lightblue ctermbg=NONE cterm=bold

" Search {{{1
" The reason to use two colors (instead of an underline) is to have one color
" for the matches for the last search, and a different color for the current
" search
highlight IncSearch cterm=NONE ctermbg=cyan ctermfg=black
highlight Search cterm=NONE ctermbg=darkcyan ctermfg=black

" Status Line {{{1
highlight StatusLine ctermbg=white ctermfg=244
highlight StatusLineNC ctermfg=239 ctermbg=249
highlight VertSplit ctermfg=239 ctermbg=239

" Mode Message {{{1
highlight ModeMsg ctermfg=black ctermbg=darkcyan cterm=bold

" Tabs {{{1
highlight TabLine cterm=NONE ctermbg=239 ctermfg=249
highlight TabLineFill cterm=NONE ctermbg=239 ctermfg=249

" Column Guide {{{1
highlight ColorColumn ctermbg=237

" Comments & Tildes {{{1
highlight comment ctermfg=darkgray
highlight SpecialKey ctermfg=238
highlight NonText ctermfg=238

" Folding {{{1
" Same as inactive status line
highlight Folded ctermfg=249 ctermbg=237

" Warnings & Errors {{{1
highlight WarningMsg ctermfg=black ctermbg=yellow cterm=bold
highlight ErrorMsg ctermfg=white ctermbg=red cterm=bold
highlight SpellBad ctermfg=red ctermbg=NONE cterm=underline
highlight SpellCap ctermfg=yellow ctermbg=NONE cterm=underline
highlight SpellRare ctermfg=yellow ctermbg=NONE cterm=underline

" Diff {{{1
" highlight DiffAdd ctermfg=darkgreen ctermbg=NONE cterm=bold
" highlight DiffAdded ctermfg=darkgreen ctermbg=NONE cterm=bold
" highlight DiffDelete ctermfg=red ctermbg=NONE cterm=bold
" highlight DiffRemoved ctermfg=red ctermbg=NONE cterm=bold
" highlight DiffChange ctermfg=lightblue ctermbg=NONE cterm=bold
" highlight DiffText ctermfg=lightblue ctermbg=NONE cterm=bold
highlight DiffAdd ctermfg=NONE ctermbg=22 cterm=NONE
highlight DiffAdded ctermfg=NONE ctermbg=22 cterm=NONE
" A white line of slashes is used when a section is removed, the `darkgray`
" here styles the slashes
highlight DiffDelete ctermfg=darkgray ctermbg=52 cterm=NONE
highlight DiffRemoved ctermfg=NONE ctermbg=52 cterm=NONE
highlight DiffChange ctermfg=NONE ctermbg=18 cterm=NONE
" Inline changed text
highlight DiffText ctermfg=NONE ctermbg=21 cterm=NONE

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

highlight markdownH1 ctermfg=white cterm=bold
highlight markdownH2 ctermfg=white cterm=bold
highlight markdownH3 ctermfg=white cterm=bold
highlight markdownH4 ctermfg=white cterm=bold
highlight markdownH5 ctermfg=white cterm=bold
highlight markdownH6 ctermfg=white cterm=bold

" Groups
highlight link markdownItalicDelimiter Comment
highlight link markdownBoldDelimiter Comment
highlight link markdownLinkText Keyword
highlight link markdownFootnote Comment
highlight link markdownFootnoteDefinition Comment
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


" Plugins {{{1

" Signify {{{2
highlight SignifyLineAdd ctermbg=NONE ctermfg=green
highlight SignifySignAdd ctermbg=NONE ctermfg=green
highlight SignifyLineChange ctermbg=NONE ctermfg=lightblue
highlight SignifyLineChangeDelete ctermbg=NONE ctermfg=lightblue
highlight SignifySignChange ctermbg=NONE ctermfg=lightblue
highlight SignifySignChangeDelete ctermbg=NONE ctermfg=lightblue
highlight SignifyLineDelete ctermbg=NONE ctermfg=red
highlight SignifyLineDeleteFirstLine ctermbg=NONE ctermfg=red
highlight SignifySignDelete ctermbg=NONE ctermfg=red
highlight SignifySignDeleteFirstLine ctermbg=NONE ctermfg=red

" Ale {{{2
highlight ALEErrorSign ctermfg=red
highlight ALEWarningSign ctermfg=yellow
highlight ALEStyleWarningSign ctermfg=yellow
highlight ALEStyleErrorSign ctermfg=yellow
