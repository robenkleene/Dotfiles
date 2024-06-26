function! s:OverrideColors()
  highlight Comment guifg=#808080 ctermfg=244 guibg=NONE ctermbg=NONE

  " Status Line
  " Don't change the background color in the status line, this allows colors
  " to be used in the status line (otherwise the background color won't match
  " for the colored section)
  " E.g., `set statusline+=%(%#WarningMsg#%m%*\ %)` Use `%#WarningMsg#` sets
  " the color and `%*` returns to the default `StatusLine` color
  " Use colors in status line, too hard to distinguish between windows otherwise
  " highlight! link StatusLine CurSearch
  " highlight! link StatusLineNC Search

  " Make colors used in statusline consistent
  highlight ErrorMsg guifg=Red ctermfg=Red guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  highlight WarningMsg guifg=Yellow ctermfg=Yellow guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  highlight netrwDir guifg=DarkCyan ctermfg=DarkCyan guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

  " Line number background looks funny when just highlighting the line number
  " with `set cursorlineopt=number`
  highlight LineNr guibg=NONE ctermbg=NONE

  " Underline never looks good for highlight line
  highlight CursorLine gui=NONE cterm=NONE
  highlight CursorLineNr gui=NONE cterm=NONE guibg=NONE ctermbg=NONE

  " Change to using a color, the underline can be hard to see when there's a
  " background color, or if the text is already underlined (e.g., for a a
  " linter error)
  highlight MatchParen guifg=cyan ctermfg=cyan guibg=NONE ctermbg=NONE gui=bold cterm=bold

  " Selection
  highlight Visual guifg=NONE ctermfg=NONE guibg=#444444 ctermbg=238 gui=NONE cterm=NONE

  " Whitespaces characters
  highlight NonText guifg=#585858 ctermfg=240 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

  " Use a distinctive foreground color for search because when search is also
  " highlighted (e.g., to do a replace inside a visual region), the search
  " will conceal the background, so the distinctive color will make the
  " matches clear even without the background
  highlight Search guibg=#444444 ctermbg=238 guifg=cyan ctermfg=cyan gui=NONE cterm=NONE
  highlight CurSearch guibg=#585858 ctermbg=240 guifg=cyan ctermfg=cyan gui=bold cterm=bold

  highlight Pmenu guibg=#444444 ctermbg=238 guifg=#A8A8A8 ctermfg=248 gui=NONE cterm=NONE
  highlight PmenuSel guibg=#585858 ctermbg=240 guifg=white ctermfg=white gui=bold cterm=bold

  " Diff
  highlight DiffDelete guifg=Red ctermfg=Red guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  highlight DiffChange guifg=Blue ctermfg=Blue guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  highlight DiffAdd guifg=LightGreen ctermfg=LightGreen guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  " These won't work here, they'd need to be in `after/syntax/diff.vim`
  " highlight! link diffAdded DiffAdd
  " highlight! link diffRemoved DiffDelete
  " highlight! link diffChanged DiffChange

  if !has('nvim')
    highlight! VertSplit guifg=#444444 ctermfg=240 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  else
    highlight! WinSeparator guifg=#444444 ctermfg=240 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  endif
  highlight! link QuickFixLine PmenuSel
  highlight! link IncSearch CurSearch
  highlight! link SpecialKey NonText
  " The wild menu background is StatusLine
  highlight! link Wildmenu Pmenu
  highlight! link PmenuSbar PmenuSel
  highlight! link PmenuThumb Pmenu

  " Messages
  highlight ErrorMsg guifg=Red guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  highlight WarningMsg guifg=Yellow guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

  " Diff
  highlight DiffAdd guifg=Green guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  highlight DiffAdded guifg=Green guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  highlight DiffDelete guifg=Red guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  highlight DiffRemoved guifg=Red guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  highlight DiffChange guifg=LightBlue guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  highlight DiffChange guifg=LightBlue guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

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
