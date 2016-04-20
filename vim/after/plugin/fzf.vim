if has('gui_running')
	finish
end
nnoremap <leader>a :Ag 
nnoremap <leader>* :Ag <C-r><C-w><cr>
nnoremap <leader>b :Buffers<CR> 
nnoremap <leader>l :BLines<CR> 
nnoremap <leader>f :Files<CR> 

function! s:AgVisual()
  let temp = @s
  norm! gv"sy
  execute "Ag " . @s
  let @s = temp
endfunction

vnoremap <leader>* :<C-u>call <SID>AgVisual()<CR>
