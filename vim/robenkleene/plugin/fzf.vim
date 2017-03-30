set rtp+=~/.fzf

nnoremap <leader>A :tabnew<CR>:Ag 

" rg
" nnoremap <leader>* :Rgf <C-r><C-w><cr>
" vnoremap <leader>* :<C-u>call <SID>RgfVisual()<CR>

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>r :History<CR>
nnoremap <leader>c :Modified<CR>

" function! s:RgfVisual()
"   let temp = @s
"   norm! gv"sy
"   execute "Rgf " . @s
"   let @s = temp
" endfunction

" `rg`
command! -bang -nargs=* Rgf
  \ call fzf#vim#grep('rg --smart-case --column --line-number --no-heading --color=always '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0) |
  " \ let @/="<args>"

" Raw `rg` for passing in custom flags
command! -bang -nargs=* Rrgf
  \ call fzf#vim#grep('rg --smart-case --column --line-number --no-heading --color=always '.<q-args>.'| tr -d "\017"', 1, <bang>0)

" Bookmarks
" function! s:RobenKleeneBookmarks()
"   redir => l:raw_bookmarks
"   silent echo $ROBENKLEENE_BOOKMARKS
"   redir END
"   let l:bookmarks = split(l:raw_bookmarks, ':')
"   return l:bookmarks
" endfunction

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
