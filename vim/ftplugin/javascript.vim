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

command! -nargs=0 Prettier :CocCommand prettier.formatFile
nnoremap <leader>f  :Prettier<CR>
vmap <localleader>f  <Plug>(coc-format-selected)
nmap <localleader>f  <Plug>(coc-format-selected)

setlocal foldmethod=indent
