if !exists(":RainbowParentheses")
  finish
endif

" For some reason this is breaking syntax highlighting in HTML?
" augroup rainbow_parentheses
"   autocmd!
"   let blacklist = ['markdown', 'html']
"   autocmd FileType * if index(blacklist, &ft) < 0 | RainbowParentheses
" augroup END
