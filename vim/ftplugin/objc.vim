setlocal suffixesadd=.h,.m

nnoremap <localleader>x :!open -a "Xcode.app" "%:p"<CR>\|:redraw!<CR>
setlocal commentstring=//\ %s
compiler xcodebuild
