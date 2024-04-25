set rtp+=$HOMEBREW_DIR/opt/fzf

nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <leader>o :FZFHistory<CR>
nnoremap <silent> <leader>t :BTags<CR>

" Don't sort old files
command! -bang -nargs=* FZFHistory call fzf#vim#history(fzf#vim#with_preview({'options': '--no-sort'}))
" Rebind `Rg` to not shell escape so flags can be used
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " .
      \ <q-args>, fzf#vim#with_preview(), <bang>0)
