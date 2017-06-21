set rtp+=~/.fzf

" rg
" nnoremap <leader>* :Rgf <C-r><C-w><cr>
" vnoremap <leader>* :<C-u>call <SID>RgfVisual()<CR>

nnoremap <leader>b :Buffers<CR>
nnoremap <localleader>l :BLines<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>e :Files<CR>
nnoremap <M-e> :Files<CR>
nnoremap <M-c> :Cd<CR>
nnoremap <leader>r :History<CR>
" nnoremap <leader>c :Modified<CR>
nnoremap <localleader>i :BTags<CR>
nnoremap <leader>i :Tags<CR>

" function! s:RgfVisual()
"   let temp = @s
"   norm! gv"sy
"   execute "Rgf " . @s
"   let @s = temp
" endfunction

" `rg`
command! -bang -nargs=* Gf Gfzf
command! -bang -nargs=* Gfzf
  \ call fzf#vim#grep('rg --column --smart-case --line-number --no-heading --color=always '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0) |
  " \ let @/="<args>"

" Raw `rg` for passing in custom flags
command! -bang -nargs=* Gfzfr
  \ call fzf#vim#grep('rg --column --smart-case --line-number --no-heading --color=always '.<q-args>.'| tr -d "\017"', 1, <bang>0)

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

" Documentation
command! -bang -nargs=* FZFVimDocumentation
  \ call fzf#vim#grep('rg --column --smart-case --line-number --no-heading --color=always '.shellescape(<q-args>).' ~/Documentation/development-references/Vim/ | tr -d "\017"', 1, <bang>0)

" Modified Files
command! Modified :call fzf#run({
\   'source':  "git ls-files -m | uniq",
\   'sink':    'e'
\ })

command! Cd :call fzf#run({
\   'source':  "cmd=\"${FZF_ALT_C_COMMAND:-\"command find -L . -mindepth 1 \\\\( -path '*/\\\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\\\) -prune -o -type d -print 2> /dev/null | cut -b3-\"}\" && eval \"$cmd\"",
\   'sink':    'Explore'
\ })
