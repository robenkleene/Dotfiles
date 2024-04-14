nnoremap Y y$

nnoremap <expr> <CR> len(getqflist()) ? ":cn<CR>" : len(argv()) > 1 ? ":next<CR>" : ":bnext<CR>"
nnoremap <expr> <S-CR> len(getqflist()) ? ":cp<CR>" : len(argv()) > 1 ? ":prev<CR>" : ":bprev<CR>"
augroup fix_return_bindings
  autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
  autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
augroup END

