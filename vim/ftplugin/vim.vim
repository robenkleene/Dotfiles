setlocal foldmethod=marker

" command! RunVimscript :update | :source %
" nnoremap <localleader>r :RunVimscript<CR>

function! s:RunVimscriptVisual() range abort
  let temp = @s
  norm! gv"sy
  execute @s
  let @s = temp
endfunction
command! -range RunVimscriptVisual <line1>,<line2>call <SID>bindings#RunVimscriptVisual()
vnoremap <localleader>e :'<,'>call <SID>RunVimscriptVisual()<CR>
