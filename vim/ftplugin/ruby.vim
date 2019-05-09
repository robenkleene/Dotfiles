" setlocal equalprg=rubocop\ --auto-correct\ --stdin\ -\ 2>/dev/null\ \|\ sed\ '1,/^====================$/d'
let b:FormatPrg = "rubocop --auto-correct --stdin - 2>&1 | sed '1,/^====================$/d'"

let b:RunMakePrg = "ruby ".fnameescape(expand('%:p'))

let b:RunErrorFormat =
      \ '%.%#from %f:%l:%m,'.
      \ '%f:%l:%m,'.
      \ '%-G%.%#'

" let b:ExecutePrg = "ruby"
let b:ExecutePrg = "irb --simple-prompt"

" This causes slowness
" setlocal foldmethod=syntax
