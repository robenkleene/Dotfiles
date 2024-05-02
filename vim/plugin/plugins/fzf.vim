set rtp+=$HOMEBREW_DIR/opt/fzf

nnoremap <silent> <leader>b :Buffers<CR>
" `:Files` is useful because it doesn't require `fd` to finish executing,
" like the `Fd:` command, which means it's usually faster
nnoremap <silent> <leader>f :Files<CR>
" `:Files` and `:RG` are particularly useful when editing in directories of
" text files
nnoremap <silent> <leader>g :RG<CR>
nnoremap <silent> <leader>o :FzfOldfiles<CR>
nnoremap <silent> <leader>t :BTags<CR>

" Don't sort old files
command! -bang -nargs=* FzfOldfiles call fzf#vim#history(fzf#vim#with_preview({'options': '--no-sort'}))
