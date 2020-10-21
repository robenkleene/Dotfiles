" Terminal Colors

if has('gui_running')
  finish
endif

" Notes for working with colors:
" `:XtermColorTable` displays the hex colors a terminal equivalents
" `:so $VIMRUNTIME/syntax/colortest.vim` displays the named colors
" Or use my command `:RunColorTest`

" `:so $VIMRUNTIME/syntax/hitest.vim` lists all the styled syntax groups
" Or use my command `:RunHighlightTest`

" Set the `augroup` before setting the color scheme
augroup MyColors
  autocmd!
  autocmd ColorScheme * call <SID>MyHighlights()
augroup END

function! s:MyHighlights() abort
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
  let s:highlightbgcolor = '236'
  let s:highlightfgcolor = 'NONE'
  " 'ColorColumn' is 80 character line
  let s:highlightgroups = ['CursorLine', 'CursorLineNr', 'CursorColumn', 'ColorColumn']
  for group in s:highlightgroups
    exe 'highlight ' . group . ' ctermbg=' . s:highlightbgcolor  . ' ctermfg=' .
          \ s:highlightfgcolor . ' cterm=NONE'
  endfor

  " Wild Menu {{{1
  highlight Wildmenu cterm=bold ctermbg=cyan ctermfg=black

  " Autocomplete {{{1
  highlight Pmenu ctermfg=white ctermbg=237
  highlight PmenuSel ctermfg=black ctermbg=cyan
  highlight PmenuSbar ctermfg=239 ctermbg=239
  highlight PmenuThumb ctermfg=244 ctermbg=244

  " Visual Selection {{{1
  " Visual selection is distinguished from `Search` because a match can either
  " be selected or not selected, so this difference in colors distinguishes
  " that.
  highlight Visual ctermbg=24 ctermfg=NONE
  " Original idea, grey background:
  " highlight MatchParen ctermfg=white ctermbg=244
  highlight MatchParen ctermfg=cyan ctermbg=NONE cterm=underline
  highlight Todo ctermfg=lightblue ctermbg=NONE cterm=bold

  " Search {{{1
  highlight IncSearch ctermbg=cyan ctermfg=black cterm=bold
  highlight Search ctermbg=cyan ctermfg=black cterm=bold

  " Status Line {{{1
  highlight StatusLine ctermbg=white ctermfg=244
  highlight StatusLineNC ctermfg=239 ctermbg=249
  highlight VertSplit ctermfg=239 ctermbg=239

  " Mode Message {{{1
  highlight ModeMsg ctermfg=black ctermbg=darkcyan cterm=bold

  " Tabs {{{1
  highlight TabLine cterm=NONE ctermbg=239 ctermfg=249
  highlight TabLineFill cterm=NONE ctermbg=239 ctermfg=249

  " Comments & Tildes {{{1
  highlight comment ctermfg=244
  highlight SpecialKey ctermfg=238
  highlight NonText ctermfg=darkgrey
  highlight qfSeparator ctermfg=238

  " Folding {{{1
  " Same as inactive status line
  highlight Folded ctermfg=249 ctermbg=237
  highlight FoldColumn ctermfg=238

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
  " Disabled because `markdownCodeBlock` clashes with heirarchical lists
  " highlight markdownCodeBlock ctermfg=grey ctermbg=NONE
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

  " Git {{{2
  highlight CocGitAddedSign ctermbg=NONE ctermfg=green
  highlight CocGitChangedSign ctermbg=NONE ctermfg=lightblue
  highlight CocGitChangedRemovedSign ctermbg=NONE ctermfg=lightblue
  highlight CocGitChangeRemovedSign ctermbg=NONE ctermfg=lightblue
  highlight CocGitRemovedSign ctermbg=NONE ctermfg=red

  " CoC {{{2
  highlight CocWarningSign ctermfg=yellow
  highlight CocErrorSign ctermfg=red
  " highlight CocWarningSign ctermfg=gray
  " highlight CocErrorSign ctermfg=gray
  highlight CocInfoSign ctermfg=gray
  highlight CocHintSign ctermfg=gray
  " Float
  highlight CocWarningFloat ctermfg=white
  highlight CocErrorFloat ctermfg=white
  " highlight CocWarningSign ctermfg=gray
  " highlight CocErrorSign ctermfg=gray
  highlight CocInfoFloat ctermfg=white
  highlight CocHintFloat ctermfg=white

  " tir_black bug fixes
  " For some reason "blue" display weird in console vim when it overlaps with the
  " highlighted cursorline (test this by running `RunColorTest` and then going
  " to the `blue` or `darkblue` lines. Changes these colors to another fixes
  " this)
  highlight rubyControl ctermfg=lightblue
  highlight rubyInterpolationDelimiter ctermfg=lightblue
  " highlight rubyControl ctermfg=110
  " highlight rubyInterpolationDelimiter ctermfg=110
endfunction

" Colorscheme
set background=dark
colorscheme tir_black
