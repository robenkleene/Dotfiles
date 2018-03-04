setlocal suffixesadd=.swift,.h,.m
nnoremap <localleader>O :!open -a "Xcode.app" "%:p"<CR>\|:redraw!<CR>

let b:LintMakePrg = "swiftlint --path ".fnameescape(expand('%:p'))
let b:LintErrorFormat =
      \ '%f:%l:%c: %trror: %m,'.
      \ '%f:%l:%c: %tarning: %m,'.
      \ '%f:%l: %trror: %m,'.
      \ '%f:%l: %tarning: %m,'.
      \ '%-G%.%#'
let b:RunMakePrg = "swift ".fnameescape(expand('%:p'))
let b:RunErrorFormat =
      \ '%f:%l:%c:%.%#\ error:\ %m,'.
      \ '%f:%l:%c:%.%#\ warning:\ %m,'.
      \ '%f:%l:%.%#\ error:\ %m,'.
      \ '%f:%l:%.%#\ warning:\ %m,'.
      \ '%-G%.%#'
