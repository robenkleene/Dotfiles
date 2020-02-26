setlocal suffixesadd=.js

let b:RunMakePrg = "node ".fnameescape(expand('%:p'))
let b:RunErrorFormat =
      \ '%AError:\ %m,'.
      \ '%AEvalError:\ %m,'.
      \ '%ARangeError:\ %m,'.
      \ '%AReferenceError:\ %m,'.
      \ '%ASyntaxError:\ %m,'.
      \ '%ATypeError:\ %m,'.
      \ '%Z%*[\ ]at\ %f:%l:%c,'.
      \ '%Z%*[\ ]%m (%f:%l:%c),'.
      \ '%*[\ ]at\ %f:%l:%c,'.
      \ '%Z%p^,%A%f:%l,%C%m,'.
      \ '%-G%.%#'
let b:FormatPrg = "prettier --parser babel"

setlocal foldmethod=indent
