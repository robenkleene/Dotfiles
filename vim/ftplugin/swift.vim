setlocal suffixesadd=.swift,.h,.m
nnoremap <localleader>X :!open -a "Xcode.app" "%:p"<CR>\|:redraw!<CR>

" Format
" setlocal equalprg=swiftformat\ --commas\ inline
let b:FormatPrg = "swiftformat --commas inline"
" When piping through `swiftlint`, it leaves an emptly blank line at the end of
" the file
nnoremap <localleader>f :Format<CR>\|:DeleteEOFWhitespace<CR>

" Lint
let b:LintMakePrg = "swiftlint --path ".fnameescape(expand('%:p'))
let b:LintErrorFormat =
      \ '%f:%l:%c: %trror: %m,'.
      \ '%f:%l:%c: %tarning: %m,'.
      \ '%f:%l: %trror: %m,'.
      \ '%f:%l: %tarning: %m,'.
      \ '%-G%.%#'
" Run
let b:RunMakePrg = "swift ".fnameescape(expand('%:p'))
let b:RunErrorFormat =
      \ '%f:%l:%c:%.%#\ error:\ %m,'.
      \ '%f:%l:%c:%.%#\ warning:\ %m,'.
      \ '%f:%l:%.%#\ error:\ %m,'.
      \ '%f:%l:%.%#\ warning:\ %m,'.
      \ '%-G%.%#'
