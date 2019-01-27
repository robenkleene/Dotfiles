" Format
setlocal equalprg=sass-convert\ --stdin\ --to\ scss
let b:FormatPrg = "sass-convert --stdin --to scss"

setlocal foldmethod=marker foldmarker={,}
