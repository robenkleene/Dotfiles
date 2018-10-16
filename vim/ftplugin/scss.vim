setlocal suffixesadd=.swift,.h,.m
nnoremap <localleader>O :!open -a "Xcode.app" "%:p"<CR>\|:redraw!<CR>

" Format
setlocal formatprg=sass-convert\ --stdin\ --to\ scss
let b:FormatPrg = "sass-convert --stdin --to scss"
