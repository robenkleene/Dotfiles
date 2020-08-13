let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}'], ['<', '>']]

augroup rainbow_parentheses
  autocmd!
  let blacklist = ['markdown']
  " autocmd FileType json,lisp RainbowParentheses
  autocmd FileType * if index(blacklist, &ft) < 0 | RainbowParentheses
augroup END
