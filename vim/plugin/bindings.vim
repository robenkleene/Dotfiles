nnoremap Y y$

" Add `zv` to quickfix bindings to show the cursor line, because these
" bindings don't respect the `foldopen` option
" (This solution is from `unimpaired`)
" nnoremap <expr> <CR> len(getqflist()) ? ":cnext<CR>zv" : len(argv()) > 1 ? ":next<CR>" : ":bnext<CR>"
" `<S-CR>` can't be bound on Apple Terminal
" nnoremap <expr> <BS> len(getqflist()) ? ":cprev<CR>zv" : len(argv()) > 1 ? ":prev<CR>" : ":bprev<CR>"
" augroup fix_return_bindings
"   autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
"   autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" augroup END

