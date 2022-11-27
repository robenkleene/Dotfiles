function! auto#MakeShebangFilesExecutable() abort
  if match(getline(1), '^\#!') == 0
    if match(getfperm(expand('%:p')), 'x') == -1
      !chmod +x "%"
    endif
  endif
endfunction

" Used for calculating quickfix height
function! auto#AdjustWindowHeight(minheight, maxheight) abort
  execute max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
  execute "normal! \<C-w>="
endfunction
