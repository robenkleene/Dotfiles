function! s:OverrideColors()
  highlight Comment guifg=#808080 guibg=NONE gui=NONE cterm=NONE
  " Don't change the background color in the status line, this allows colors
  " to be used in the status line (otherwise the background color won't match
  " for the colored section)
  " E.g., `set statusline+=%(%#WarningMsg#%m%*\ %)` Use `%#WarningMsg#` sets
  " the color and `%*` returns to the default `StatusLine` color
  highlight StatusLine guifg=#A8A8A8 guibg=NONE gui=NONE cterm=NONE
  highlight! link StatusLineNC Comment
  " Make colors used in statusline consistent
  highlight ErrorMsg guifg=Red guibg=NONE gui=NONE cterm=NONE
  highlight WarningMsg guifg=Yellow guibg=NONE gui=NONE cterm=NONE
  highlight netrwDir guifg=DarkCyan guibg=NONE gui=NONE cterm=NONE
  " highlight! link ModeMsg ErrorMsg
  " Underrline never looks good for highlight line
  highlight CursorLine cterm=none
  highlight CursorLineNr cterm=none

  " Whitespaces characters
  highlight NonText guifg=#444444 guibg=NONE gui=NONE cterm=NONE
  " highlight! link NonText Comment

  highlight MatchParen guifg=DarkCyan guibg=NONE gui=bold cterm=bold
  highlight Search guibg=DarkCyan guifg=Black gui=NONE cterm=NONE
  highlight CurSearch guibg=Cyan guifg=Black gui=NONE cterm=NONE

  highlight Visual guibg=#585858 guifg=white gui=NONE cterm=NONE
  highlight! link ModeMsg Visual

  highlight Pmenu guibg=#444444 guifg=#A8A8A8 gui=NONE cterm=NONE

  highlight! VertSplit guibg=NONE guifg=#444444 gui=NONE cterm=NONE
  highlight! link QuickFixLine Visual
  highlight! link IncSearch CurSearch
  highlight! link SpecialKey NonText
  " The wild menu background is StatusLine
  highlight! link Wildmenu ModeMsg
  highlight! link PmenuSel Visual
  highlight! link PmenuSbar Visual
  highlight! link PmenuThumb Pmenu

  if !has('nvim')
    " Markdown

    " Custom
    highlight link Checkbox Comment
    " Markdown list items with checkboxes breaks assigning the correct syntax
    " group to URLs, so just assign the `Comment` style to our made up
    " `UrlNoSpell` group
    highlight link UrlNoSpell Comment
    " Just underline for mispelled words because color schemes can't be
    " trusted to provide enough contrast to keep things legible
    highlight clear SpellBad
    highlight SpellBad cterm=underline

    " Markup
    highlight markdownItalic guifg=white gui=italic cterm=italic
    highlight markdownBold guifg=white gui=bold cterm=bold
    highlight markdownLinkText guifg=lightblue gui=underline cterm=underline
    highlight markdownId guifg=lightblue gui=underline cterm=underline

    " Headers
    highlight markdownH1 guifg=white gui=bold cterm=bold
    highlight markdownH2 guifg=white gui=bold cterm=bold
    highlight markdownH3 guifg=white gui=bold cterm=bold
    highlight markdownH4 guifg=white gui=bold cterm=bold
    highlight markdownH5 guifg=white gui=bold cterm=bold
    highlight markdownH6 guifg=white gui=bold cterm=bold

    " Link
    highlight link markdownCode Comment
    highlight link markdownCodeBlock Comment
    highlight link markdownBlockquote Comment
    highlight link markdownBoldDelimiter NonText
    highlight link markdownCodeDelimiter NonText
    highlight link markdownFootnote Comment
    highlight link markdownFootnoteDefinition Comment
    highlight link markdownH1Delimiter NonText
    highlight link markdownH2Delimiter NonText
    highlight link markdownH3Delimiter NonText
    highlight link markdownH4Delimiter NonText
    highlight link markdownH5Delimiter NonText
    highlight link markdownH6Delimiter NonText
    highlight link markdownHeadingDelimiter NonText
    highlight link markdownItalicDelimiter NonText
    highlight link markdownLinkDelimiter NonText
    highlight link markdownLinkText Keyword
    highlight link markdownLinkTextDelimiter NonText
    highlight link markdownListMarker Comment
    highlight link markdownUrl Comment
  endif
endfunction
augroup override_colors
    autocmd!
    autocmd ColorScheme * call <SID>OverrideColors()
augroup END
