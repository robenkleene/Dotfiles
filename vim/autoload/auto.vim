function! auto#MakeShebangFilesExecutable() abort
  if match(getline(1), '^\#!') == 0
    if match(getfperm(expand('%:p')), 'x') == -1
      !chmod +x %
    endif
  endif
endfunction

function! auto#AdjustWindowHeight(minheight, maxheight) abort
  execute max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
  execute "normal! \<C-w>="
endfunction

" function! auto#fnameescape(file) abort
"   if exists('*fnameescape')
"     return fnameescape(a:file)
"   else
"     return escape(a:file," \t\n*?[{`$\\%#'\"|!<")
"   endif
" endfunction
" function! auto#setup_netrw() abort
"   " This conflicts with `gcc` for `commentary` so it causes a delay
"   nnoremap <buffer> <silent> gc :exe 'keepjumps cd ' .auto#fnameescape(b:netrw_curdir)<CR>
" endfunction
