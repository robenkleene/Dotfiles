if !has('nvim')
  " Disable spell check in URLs
  syn match UrlNoSpell '([^[:space:]]\+)' contains=@NoSpell
  " Markdown list items with checkboxes breaks assigning the correct syntax
  " group to URLs, so just assign the `Comment` style to our made up
  " `UrlNoSpell` group
  highlight link UrlNoSpell Comment

  " Syntax Colors

  " Markup
  highlight markdownItalic gui=italic cterm=italic
  highlight markdownBold gui=bold cterm=bold
  highlight markdownLinkText guifg=#87afdf gui=underline cterm=underline
  highlight markdownId guifg=#87afdf gui=underline cterm=underline

  " Headers
  highlight markdownH1 guifg=white gui=bold cterm=bold
  highlight markdownH2 guifg=white gui=bold cterm=bold
  highlight markdownH3 guifg=white gui=bold cterm=bold
  highlight markdownH4 guifg=white gui=bold cterm=bold
  highlight markdownH5 guifg=white gui=bold cterm=bold
  highlight markdownH6 guifg=white gui=bold cterm=bold

  " Link
  highlight link markdownBlockquote Comment
  highlight link markdownBoldDelimiter Comment
  highlight link markdownCode Comment
  highlight link markdownCodeDelimiter Comment
  highlight link markdownFootnote Comment
  highlight link markdownFootnoteDefinition Comment
  highlight link markdownH1Delimiter Comment
  highlight link markdownH2Delimiter Comment
  highlight link markdownH3Delimiter Comment
  highlight link markdownH4Delimiter Comment
  highlight link markdownH5Delimiter Comment
  highlight link markdownH6Delimiter Comment
  highlight link markdownHeadingDelimiter Comment
  highlight link markdownItalicDelimiter Comment
  highlight link markdownLinkDelimiter Comment
  highlight link markdownLinkText Keyword
  highlight link markdownLinkTextDelimiter Comment
  highlight link markdownListMarker Comment
  highlight link markdownUrl Comment
endif
