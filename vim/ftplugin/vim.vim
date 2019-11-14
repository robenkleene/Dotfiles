setlocal foldmethod=marker

function! s:RunVimscriptVisual() range abort
  let temp = @s
  normal! gv"sy
  execute @s
  let @s = temp
endfunction
function! s:RunVimscript() range abort
  let temp = @s
  normal! gg"syG
  execute @s
  let @s = temp
endfunction
command! -range RunVimscriptVisual <line1>,<line2>call <SID>bindings#RunVimscriptVisual()
vnoremap <buffer> <localleader>r :'<,'>call <SID>RunVimscriptVisual()<CR>
nnoremap <buffer> <localleader>r :call <SID>RunVimscript()<CR>
