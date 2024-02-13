function! s:OverrideColors()
  " Don't change the background color in the status line, this allows colors
  " to be used in the status line (otherwise the background color won't match
  " for the colored section)
  " E.g., `set statusline+=%(%#WarningMsg#%m%*\ %)` Use `%#WarningMsg#` sets
  " the color and `%*` returns to the default `StatusLine` color
  highlight StatusLine guifg=White guibg=NONE gui=bold cterm=bold
  highlight StatusLineNC guifg=#999999 guibg=NONE gui=NONE cterm=NONE
  " Make colors used in statusline consistent
  highlight ErrorMsg guifg=Red guibg=NONE gui=NONE cterm=NONE
  highlight WarningMsg guifg=Yellow guibg=NONE gui=NONE cterm=NONE
  highlight netrwDir guifg=DarkCyan guibg=NONE gui=NONE cterm=NONE
  " highlight! link ModeMsg ErrorMsg
  " Underrline never looks good for highlight line
  highlight CursorLine cterm=none
  highlight CursorLineNr cterm=none

  highlight Comment guifg=#888888 guibg=NONE gui=NONE cterm=NONE
  " Whitespaces characters
  highlight NonText guifg=#333333 guibg=NONE gui=NONE cterm=NONE
  " highlight! link NonText Comment

  highlight MatchParen guifg=DarkCyan guibg=NONE gui=bold cterm=bold
  highlight Search guibg=DarkCyan guifg=Black gui=NONE cterm=NONE
  highlight CurSearch guibg=Cyan guifg=Black gui=NONE cterm=NONE

  highlight Visual guibg=#888888 guifg=white gui=NONE cterm=NONE

  highlight Pmenu guibg=#555555 guifg=white gui=NONE cterm=NONE

  highlight! link QuickFixLine Visual
  highlight! link IncSearch CurSearch
  highlight! link ModeMsg Visual
  highlight! link SpecialKey NonText
  " The wild menu background is StatusLine
  highlight! link Wildmenu Visual
  highlight! link PmenuSel Wildmenu
  highlight! link PmenuSbar Wildmenu
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
    highlight link markdownBoldDelimiter Comment
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
endfunction
augroup override_colors
    autocmd!
    autocmd ColorScheme * call <SID>OverrideColors()
augroup END
