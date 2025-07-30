set rtp+=$HOMEBREW_DIR/opt/fzf

" Doesn't support, e.g., `:bd` to close a buffer
" nnoremap <silent> <leader>b :Buffers<CR>

" The logic for why we keep this two commands but disable the rest is that
" other commands like `:ls` and `:ol` show a list and then allow opening
" individual files from that list. Other approaches to using tools like `fd`
" and `rg`, only allow populating the argument list or quickfix list, i.e.,
" there's no way to just pick one result to open. So these commands fill that
" niche of being able to open a single `fd` or `rg` result.
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :RG<CR>

" Doesn't support the jump list, e.g., `C-o` won't go back to previous
" location
" nnoremap <silent> <leader>l :BLines<CR>
" Not sure this is used enough to keep?
" nnoremap <silent> <leader>o :History<CR>
