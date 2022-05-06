setlocal suffixesadd=.h,.m,.swift
let b:FormatPrg = "clang-format -style=file"
setlocal commentstring=//\ %s

nnoremap <buffer> <localleader>X :!open -a "Xcode.app" "%:p"<CR>\|:redraw!<CR>

nnoremap <buffer> <localleader>yb :YankBreakpoint<CR>

command! YankBreakpoint :call <SID>YankBreakpoint()
function! s:YankBreakpoint()
  let @@ = "b ".expand("%:p").":".line('.')
  call system('~/.bin/safecopy', @@)
  echo "Yanked breakpoint"
endfunction
