setlocal foldmethod=indent

" setlocal equalprg=shfmt\ -i\ 2\ -ci
let b:FormatPrg = "shfmt -i 2 -ci"

let b:RunMakePrg = "sh ".fnameescape(expand('%:p'))
