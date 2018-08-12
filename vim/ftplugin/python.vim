" Format
let b:FormatPrg = "autopep8 --aggressive --aggressive -"
" When piping through `swiftlint`, it leaves an emptly blank line at the end of
" the file
nnoremap <localleader>f :Format<CR>
