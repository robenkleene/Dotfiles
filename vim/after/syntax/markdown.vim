if !has('nvim')
  " Checkboxes aren't part of Markdown syntax, and their lack of support
  " causes some ugly syntax issues, this cleans that up. `\@<=` leaves the
  " `- ` to `markdownListMarker`.
  syn match markdownCheckbox '\%(^\s*[-*+] \)\@<=\[[ xX]\]'

  " Disable spell check in URLs, redefining `markdownUrl` with `@NoSpell`
  " keeps its `markdownLink` highlighting
  syn match markdownUrl "\S\+" nextgroup=markdownUrlTitle skipwhite contained contains=@NoSpell
  syn region markdownUrl matchgroup=markdownUrlDelimiter start="<" end=">" oneline keepend nextgroup=markdownUrlTitle skipwhite contained contains=@NoSpell
endif
