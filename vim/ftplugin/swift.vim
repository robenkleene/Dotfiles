setlocal suffixesadd=.swift,.h,.m
nnoremap <localleader>O :!open -a "Xcode.app" "%:p"<CR>\|:redraw!<CR>

" nnoremap <localleader>r :!swift "%"<CR>
nnoremap <localleader>r :call <SID>RunSwift()<CR>
function! s:RunSwift() abort
  let l:original_makeprg = &makeprg
  let l:original_errorformat = &errorformat
  let &makeprg="swift ".fnameescape(expand('%:p'))
  set errorformat=
        \%f:%l:%c:%.%#\ error:\ %m,
        \%f:%l:%c:%.%#\ warning:\ %m,
        \%f:%l:%.%#\ error:\ %m,
        \%f:%l:%.%#\ warning:\ %m,
        \%-G%.%#
  make
  let &makeprg = l:original_makeprg
  let &errorformat = l:original_errorformat
endfunction
