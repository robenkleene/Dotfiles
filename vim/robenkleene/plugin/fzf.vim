" ag
" let $FZF_DEFAULT_COMMAND= 'ag -g ""'
" rg
let $FZF_DEFAULT_COMMAND= 'rg --hidden --files -g ""'

set rtp+=/usr/local/opt/fzf

nnoremap <leader>A :tabnew<CR>:Ag 

" ag
" nnoremap <leader>a :Ag 
" nnoremap <leader>* :Ag <C-r><C-w><cr>
" vnoremap <leader>* :<C-u>call <SID>AgVisual()<CR>
" rg
nnoremap <leader>a :Rg 
nnoremap <leader>* :Rg <C-r><C-w><cr>
vnoremap <leader>* :<C-u>call <SID>RgVisual()<CR>

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>r :History<CR>
nnoremap <leader>c :Modified<CR>

function! s:RgVisual()
  let temp = @s
  norm! gv"sy
  execute "Rg " . @s
  let @s = temp
endfunction

function! s:AgVisual()
  let temp = @s
  norm! gv"sy
  execute "Ag " . @s
  let @s = temp
endfunction

" rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep('rg --smart-case  --column --line-number --no-heading --color=always '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0) |
  \ let @/="<args>"

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

" Bookmarks
command! B :call fzf#run({
\   'source':  <sid>RobenKleeneBookmarks(),
\   'sink':    'Explore'
\ })

command! -bang -nargs=* FZFVimDocumentation
  \ call fzf#vim#grep('rg --smart-case  --column --line-number --no-heading --color=always '.shellescape(<q-args>).' ~/Documentation/development-references/Vim/ | tr -d "\017"', 1, <bang>0)

" Modified Files
command! Modified :call fzf#run({
\   'source':  "git ls-files -m | uniq",
\   'sink':    'e'
\ })
