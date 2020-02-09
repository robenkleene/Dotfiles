let b:FormatPrg = "clang-format -style=file"

setlocal path+=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/

" let b:RunMakePrg = "./a.out"
" This doesn't work for some reason (there's an error populating the quickfix
" list if it fails) so running is two steps
" let b:RunMakePrg = "cc ".fnameescape(expand('%:p')). " && ./a.out"
" set makeprg=cc\ %
let &makeprg = 'cd '.fnameescape(expand('%:p:h')).' && cc '.fnameescape(expand('%:t'))
nnoremap <buffer> <localleader>r :make<CR>:call <SID>Run()<CR>
function! s:Run() abort
  if len(getqflist()) == 0
    exe '!'.fnameescape(expand('%:p:h')).'/a.out'
  endif
endfunction
