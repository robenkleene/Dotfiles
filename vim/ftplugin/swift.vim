setlocal suffixesadd=.swift,.h,.m
nnoremap <localleader>x :!open -a "Xcode.app" "%:p"<CR>\|:redraw!<CR>
compiler xcodebuild
