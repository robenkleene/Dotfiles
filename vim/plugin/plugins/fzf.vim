set rtp+=$HOMEBREW_DIR/opt/fzf

"nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>t :BTags<CR>
nnoremap <silent> <leader>T :Tags<CR>

" Don't sort old files
command! -bang -nargs=* FzfOldfiles call fzf#vim#history(fzf#vim#with_preview({'options': '--no-sort'}))
