setlocal suffixesadd=.h,.m,.swift

nnoremap <buffer> <localleader>X :!open -a "Xcode.app" "%:p"<CR>\|:redraw!<CR>
setlocal commentstring=//\ %s
