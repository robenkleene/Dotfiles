let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

augroup rainbow_parentheses
  autocmd!
  autocmd FileType json,lisp RainbowParentheses
augroup END
