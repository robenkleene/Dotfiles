set rtp+=$HOMEBREW_DIR/opt/fzf

nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>o :FzfOldfiles<CR>
nnoremap <silent> <leader>t :BTags<CR>

" Don't sort old files
command! -bang -nargs=* FzfOldfiles call fzf#vim#history(fzf#vim#with_preview({'options': '--no-sort'}))
