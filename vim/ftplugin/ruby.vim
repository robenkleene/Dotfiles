" setlocal equalprg=rubocop\ --auto-correct\ --stdin\ -\ 2>/dev/null\ \|\ sed\ '1,/^====================$/d'
let b:FormatPrg = "rubocop --auto-correct --stdin - 2>&1 | sed '1,/^====================$/d'"

let b:RunMakePrg = "ruby ".fnameescape(expand('%:p'))

let RunErrorFormat =
      \ '%W %\+%\d%\+) Failure:,'.
      \ '%C%m [%f:%l]:,'.
      \ '%E %\+%\d%\+) Error:,'.
      \ '%C%m:,'.
      \ '%C    %f:%l:%.%#,'.
      \ '%C%m,'.
      \ '%Z %#,'.
      \ '%-G%.%#'

" let b:ExecutePrg = "ruby"
let b:ExecutePrg = "irb --simple-prompt"

let b:TagPrg = "ripper-tags -R"
