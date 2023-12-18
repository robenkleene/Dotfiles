function! s:OverrideColors()
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

if !has('nvim')
  " Theme
  set background=dark
  " Set after plug sync (doesn't help when installing themes)
  " let g:embark_terminal_italics = 1
  " colorscheme embark
  " colorscheme gotham
  " colorscheme catppuccin_mocha
  " colorscheme night-owl
  " colorscheme nightfly
  " colorscheme iceberg
  " colorscheme nightfox
  colorscheme duskfox
endif
