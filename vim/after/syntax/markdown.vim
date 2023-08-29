if !has('nvim')
  " Disable spell check in URLs
  syn match UrlNoSpell '([^[:space:]]\+)' contains=@NoSpell
endif
