if has('gui_running')
	finish
end
let $FZF_DEFAULT_COMMAND= 'ag -g ""'
set rtp+=/usr/local/opt/fzf

nnoremap <leader>a :Ag 
nnoremap <leader>* :Ag <C-r><C-w><cr>
nnoremap <leader>b :Buffers<CR> 
nnoremap <leader>l :BLines<CR> 
nnoremap <leader>f :Files<CR> 
nnoremap <leader>h :History<CR> 

function! s:AgVisual()
  let temp = @s
  norm! gv"sy
  execute "Ag " . @s
  let @s = temp
endfunction

vnoremap <leader>* :<C-u>call <SID>AgVisual()<CR>

" Bookmarks
function! s:RobenKleeneBookmarks()
  redir => l:raw_bookmarks
  silent echo $ROBENKLEENE_BOOKMARKS
  redir END
  let l:bookmarks = split(l:raw_bookmarks, ':')
  return l:bookmarks
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

command! B :call fzf#run({
\   'source':  <sid>RobenKleeneBookmarks(),
\   'sink':    'Explore'
\ })

command! Modified :call fzf#run({
\   'source':  "git ls-files -m | uniq",
\   'sink':    'e'
\ })
