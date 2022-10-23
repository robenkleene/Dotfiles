vim.cmd([[
  highlight MatchParen guifg=lightblue guibg=NONE gui=underline cterm=underline
  " Colors
  highlight markdownLinkText gui=underline cterm=underline
  highlight markdownLinkText guifg=#87afdf
  highlight markdownCode guifg=grey guibg=NONE
  " Disabled because `markdownCodeBlock` clashes with heirarchical lists
  " highlight markdownCodeBlock guifg=grey guibg=NONE
  highlight markdownListMarker guifg=grey
  highlight markdownItalic gui=bold cterm=bold
  highlight markdownBold gui=bold cterm=bold

  highlight markdownH1 guifg=white gui=bold cterm=bold
  highlight markdownH2 guifg=white gui=bold cterm=bold
  highlight markdownH3 guifg=white gui=bold cterm=bold
  highlight markdownH4 guifg=white gui=bold cterm=bold
  highlight markdownH5 guifg=white gui=bold cterm=bold
  highlight markdownH6 guifg=white gui=bold cterm=bold

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
  highlight link markdownH1Delimiter Comment
  highlight link markdownH2Delimiter Comment
  highlight link markdownH3Delimiter Comment
  highlight link markdownH4Delimiter Comment
  highlight link markdownH5Delimiter Comment
  highlight link markdownH6Delimiter Comment
]])

