if !has('nvim')
  " Checkboxes aren't part of Markdown syntax, and their lack of support
  " causes some ugly syntax issues, this cleans that up.
  syn match Checkbox '^\s*\- \[[ x]\]'

  " Disable spell check in URLs
  syn match UrlNoSpell '\[[^\]]*\](\S\+)' contains=@NoSpell
endif
