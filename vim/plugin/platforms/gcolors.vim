" GUI Colors

if !has('gui_running')
  finish
endif

colorscheme ir_black
set background=dark

augroup MyGUIColors
  autocmd!
  autocmd ColorScheme * call <SID>MyGUIHighlights()
augroup END

function! s:MyGUIHighlights() abort

  " Background {{{1
  let s:bgcolor = '#232323'
  let s:backgroundgroups = ['CursorColumn', 'LineNr',
              \ 'NonText', 'SpecialKey', 'VertSplit',
              \ 'Normal', 'FoldColumn', 'SignColumn']
  " Set Background Colors
  for group in s:backgroundgroups
    exe 'highlight ' . group . ' guibg=' . s:bgcolor
  endfor
  
  " Line Numbers {{{1
  highlight LineNr guifg=#7c7c7c
  
  " Cursor Line {{{1
  let s:highlightbgcolor = '#3A3A3A'
  let s:highlightfgcolor = 'NONE'
  
  let s:highlightgroups = ['CursorLine', 'CursorLineNr', 'CursorColumn']
  for group in s:highlightgroups
    exe 'highlight ' . group . ' guibg=' . s:highlightbgcolor  . ' guifg=' .  
          \ s:highlightfgcolor
  endfor
  
  " Wild Menu {{{1
  highlight Wildmenu guibg=cyan guifg=black
  
  " Autocomplete {{{1
  highlight Pmenu guifg=white guibg=#666666
  highlight PmenuSel guifg=black guibg=cyan
  
  " Visual Selection {{{1
  let s:selectionbgcolor = 'darkcyan'
  let s:selectionfgcolor = 'black'
  let s:selectiongroups = ['Visual', 'MatchParen']
  for group in s:selectiongroups
      exe 'highlight ' . group . ' guibg=' . s:selectionbgcolor  . ' guifg=' .  
                  \ s:selectionfgcolor
  endfor
  
  " Search {{{1
  highlight IncSearch gui=NONE guifg=black guibg=cyan
  highlight Search gui=NONE guifg=black guibg=darkcyan
  
  " StatusLine {{{1
  highlight StatusLine guibg=#666666 guifg=white gui=NONE
  highlight StatusLineNC guifg=#B2B2B2 guibg=#4E4E4E
  
  " Mode Message {{{1
  highlight ModeMsg guifg=black guibg=darkcyan gui=bold
  " Tabs {{{1
  highlight TabLine gui=NONE guibg=#4E4E4E guifg=#B2B2B2
  highlight TabLineFill gui=NONE guibg=#4E4E4E guifg=#B2B2B2
  
  " Tabs {{{1
  highlight TabLine gui=NONE guifg=#4E4E4E guibg=#B2B2B2
  highlight TabLineFill gui=NONE guifg=#4E4E4E guibg=#B2B2B2
  
  " Column Guide {{{1
  highlight ColorColumn guibg=#3A3A3A
  
  " Tildes {{{1
  highlight NonText guifg=DarkGray
  
  " Comments & Tildes {{{1
  highlight comment guifg=darkgray
  highlight SpecialKey guifg=#303030
  highlight NonText guifg=#303030
  
  " Folding {{{1
  " Same as inactive status line
  highlight Folded guifg=#B2B2B2 guibg=#3A3A3A
  
  " Warnings & Errors {{{1
  highlight WarningMsg guifg=black guibg=yellow gui=bold
  highlight ErrorMsg guifg=white guibg=red gui=bold
  highlight SpellBad guifg=red guibg=NONE gui=underline
  highlight SpellCap guifg=yellow guibg=NONE gui=underline
  
  " Diff {{{1
  highlight DiffAdd guifg=darkgreen guibg=NONE gui=bold
  highlight DiffAdded guifg=darkgreen guibg=NONE gui=bold
  highlight DiffDelete guifg=red guibg=NONE gui=bold
  highlight DiffRemoved guifg=red guibg=NONE gui=bold
  highlight DiffChange guifg=lightblue guibg=NONE gui=bold
  highlight DiffText guifg=lightblue guibg=NONE gui=bold
  
  " Markdown {{{1
  
  " Custom Syntax
  " Colors
  highlight markdownLinkText gui=underline gui=underline
  highlight markdownLinkText guifg=#88B0D5
  highlight markdownCode guifg=grey guibg=NONE
  highlight markdownCodeBlock guifg=grey guibg=NONE
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
  
  " Syntastic {{{2
  highlight SyntasticErrorSign guifg=red
  highlight SyntasticWarningSign guifg=yellow
  highlight SyntasticStyleWarningSign guifg=yellow

endfunction