nnoremap <leader>* :Rg <C-r><C-w><cr>
vnoremap <leader>* :<C-u>call <SID>RgVisual()<CR>

function! s:RgVisual()
  let temp = @s
  norm! gv"sy
  execute "Rg " . @s
  let @s = temp
endfunction
