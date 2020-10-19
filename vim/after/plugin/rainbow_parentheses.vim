if !exists(":RainbowParentheses")
  finish
endif

" For some reason this is breaking syntax highlighting?
" Plus this blacklist implementation doesn't seem to work
" augroup rainbow_parentheses
"   autocmd!
"   let blacklist = ['markdown', 'html', 'qf']
"   autocmd FileType * if index(blacklist, &ft) < 0 | RainbowParentheses
" augroup END


