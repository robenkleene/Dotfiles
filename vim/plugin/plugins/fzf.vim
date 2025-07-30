set rtp+=$HOMEBREW_DIR/opt/fzf

" Doesn't support, e.g., `:bd` to close a buffer
" nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :RG<CR>
" Doesn't support the jump list, e.g., `C-o` won't go back to previous
" location
" nnoremap <silent> <leader>l :BLines<CR>
" Not sure this is used enough to keep?
" nnoremap <silent> <leader>o :History<CR>
