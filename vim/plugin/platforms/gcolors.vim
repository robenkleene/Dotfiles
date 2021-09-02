" GUI Colors

if !has('gui_running') && !&termguicolors
  finish
endif

" Notes for working with colors:
" `:XtermColorTable` displays the hex colors a terminal equivalents
" `:so $VIMRUNTIME/syntax/colortest.vim` displays the named colors
" Or use my command `:RunColorTest`

" `:so $VIMRUNTIME/syntax/hitest.vim` lists all the styled syntax groups
" Or use my command `:RunHighlightTest`

" Colorscheme
set background=dark
colorscheme ir_black

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
    exe 'highlight ' . group . ' guibg=' . s:bgcolor
  endfor

  " Line Numbers {{{1
  highlight LineNr guibg=NONE guifg=#444444

  " Cursor Line {{{1
  let s:highlightbgcolor = '#303030'
  let s:highlightfgcolor = 'NONE'
  " 'ColorColumn' is 80 character line
  let s:highlightgroups = ['CursorLine', 'CursorLineNr', 'CursorColumn']
  for group in s:highlightgroups
    exe 'highlight ' . group . ' guibg=' . s:highlightbgcolor  . ' guifg=' .
          \ s:highlightfgcolor . ' gui=NONE'
  endfor

  " Disable underlining line numbers
  highlight CursorColumn cterm=NONE
  highlight CursorLine cterm=NONE
  highlight CursorLineNR cterm=NONE

  " Wild Menu {{{1
  highlight ColorColumn guibg=#262626

  " Wild Menu {{{1
  highlight Wildmenu guifg=black guibg=#69a9FF

  " Autocomplete {{{1
  highlight Pmenu guifg=white guibg=#3a3a3a
  highlight PmenuSel guifg=black guibg=#69a9FF
  highlight PmenuSbar guifg=#4e4e4e guibg=#4e4e4e
  highlight PmenuThumb guifg=#808080 guibg=#808080

  " Visual Selection {{{1
  " Visual selection is distinguished from `Search` because a match can either
  " be selected or not selected, so this difference in colors distinguishes
  " that.
  highlight Visual guibg=#005f87 guifg=NONE gui=NONE
  highlight Visual ctermbg=24 ctermfg=NONE cterm=NONE
  " Original idea, grey background:
  " highlight MatchParen guifg=white guibg=#808080
  highlight MatchParen guifg=lightblue guibg=NONE gui=underline
  highlight MatchParen cterm=underline
  highlight Todo guifg=lightblue guibg=NONE gui=bold

  " Search {{{1
  " Make sure the cursor shows up over this color, that's important when
  " moving through search matches with `n` and `N`.
  highlight IncSearch guibg=#69a9FF guifg=black gui=NONE
  highlight Search guibg=#69a9FF guifg=black gui=NONE
  highlight IncSearch cterm=NONE
  highlight Search cterm=NONE

  " Status Line {{{1
  highlight StatusLine guifg=white guibg=#808080
  highlight StatusLineNC guifg=#b2b2b2 guibg=#4e4e4e
  highlight VertSplit guifg=#4e4e4e guibg=#4e4e4e

  " Mode Message {{{1
  highlight ModeMsg guifg=black guibg=darkcyan gui=bold

  " Tabs {{{1
  highlight TabLine gui=NONE guibg=#4e4e4e guifg=#b2b2b2
  highlight TabLine cterm=NONE
  highlight TabLineFill gui=NONE guibg=#4e4e4e guifg=#b2b2b2
  highlight TabLineFill cterm=NONE

  " Comments & Tildes {{{1
  highlight comment guifg=#808080
  highlight SpecialKey guifg=#444444
  highlight NonText guifg=darkgrey
  highlight qfSeparator guifg=#444444

  " Folding {{{1
  " Same as inactive status line
  highlight Folded guifg=#b2b2b2 guibg=#3a3a3a
  highlight FoldColumn guifg=#444444

  " Warnings & Errors {{{1
  highlight WarningMsg guifg=black guibg=yellow gui=bold
  highlight ErrorMsg guifg=white guibg=red gui=bold
  highlight SpellBad guifg=red guibg=NONE gui=underline
  highlight SpellCap guifg=yellow guibg=NONE gui=underline
  highlight SpellRare guifg=yellow guibg=NONE gui=underline

  " Diff {{{1
  highlight DiffAdd guifg=green guibg=NONE gui=bold
  highlight DiffAdded guifg=green guibg=NONE gui=bold
  highlight DiffDelete guifg=red guibg=NONE gui=bold
  highlight DiffRemoved guifg=red guibg=NONE gui=bold
  highlight DiffChange guifg=darkcyan guibg=NONE gui=bold
  " Inline changed text
  highlight DiffText guifg=lightblue guibg=NONE gui=bold
  " highlight DiffAdd guifg=NONE guibg=22 gui=NONE
  " highlight DiffAdded guifg=NONE guibg=22 gui=NONE
  " highlight DiffRemoved guifg=NONE guibg=52 gui=NONE
  " highlight DiffChange guifg=NONE guibg=18 gui=NONE
  " A white line of slashes is used when a section is removed, the `darkgray`
  " here styles the slashes
  " highlight DiffDelete guifg=darkgray guibg=52 gui=NONE
  " Inline changed text
  " highlight DiffText guifg=NONE guibg=21 gui=NONE
  highlight diffFile guifg=NONE gui=bold
  highlight diffOldFile guifg=NONE gui=bold
  highlight diffNewFile guifg=white gui=bold
  highlight diffLine guifg=white guibg=#4e4e4e gui=bold
  highlight diffSubname guifg=white guibg=#4e4e4e gui=bold
  highlight diffIndexLine guifg=#808080

  " Markdown {{{1

  " Custom Syntax
  " Colors
  highlight markdownLinkText gui=underline gui=underline
  highlight markdownLinkText guifg=#87afdf
  highlight markdownCode guifg=grey guibg=NONE
  " Disabled because `markdownCodeBlock` clashes with heirarchical lists
  " highlight markdownCodeBlock guifg=grey guibg=NONE
  highlight markdownListMarker guifg=grey
  highlight markdownItalic gui=bold
  highlight markdownBold gui=bold

  highlight markdownH1 guifg=white gui=bold
  highlight markdownH2 guifg=white gui=bold
  highlight markdownH3 guifg=white gui=bold
  highlight markdownH4 guifg=white gui=bold
  highlight markdownH5 guifg=white gui=bold
  highlight markdownH6 guifg=white gui=bold

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
  highlight CocGitAddedSign guibg=NONE guifg=green
  highlight CocGitChangedSign guibg=NONE guifg=lightblue
  highlight CocGitChangedRemovedSign guibg=NONE guifg=lightblue
  highlight CocGitChangeRemovedSign guibg=NONE guifg=lightblue
  highlight CocGitRemovedSign guibg=NONE guifg=red

  " CoC {{{2
  highlight CocWarningSign guifg=yellow
  highlight CocErrorSign guifg=red
  " highlight CocWarningSign guifg=gray
  " highlight CocErrorSign guifg=gray
  highlight CocInfoSign guifg=gray
  highlight CocHintSign guifg=gray
  " Float
  highlight CocWarningFloat guifg=white
  highlight CocErrorFloat guifg=white
  " highlight CocWarningSign guifg=gray
  " highlight CocErrorSign guifg=gray
  highlight CocInfoFloat guifg=white
  highlight CocHintFloat guifg=white

  " tir_black bug fixes
  " For some reason "blue" display weird in console vim when it overlaps with the
  " highlighted cursorline (test this by running `RunColorTest` and then going
  " to the `blue` or `darkblue` lines. Changes these colors to another fixes
  " this)
  highlight rubyControl guifg=lightblue
  highlight rubyInterpolationDelimiter guifg=lightblue
  " highlight rubyControl guifg=#87afdf
  " highlight rubyInterpolationDelimiter guifg=#87afdf
endfunction

