set rtp+=$HOMEBREW_DIR/opt/fzf

" Use `:b` tab completion instead
" nnoremap <silent> <leader>b :Buffers<CR>
" Use `g/pattern/` insead
" nnoremap <silent> <leader>l :BLines<CR>

" Just use the most recent `:marks` instead or `:[ol]dfiles` folled by `:e #<<buffer-number>`
" nnoremap <silent> <leader>o :History<CR>
nnoremap <silent> <leader>g :RG<CR>
nnoremap <silent> <leader>f :Files<CR>
" Just use `:tags` tab completion instead
" nnoremap <silent> <leader>t :BTags<CR>
" nnoremap <silent> <leader>T :Tags<CR>
" nnoremap <silent> <leader>m :Marks<CR>
