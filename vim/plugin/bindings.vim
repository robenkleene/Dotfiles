nnoremap Y yg_

nnoremap <expr> <return> len(getqflist()) ? ":cn<CR>" : len(argv()) > 1 ? ":next<CR>" : ":bnext<CR>"
nnoremap <expr> <BS> len(getqflist()) ? ":cp<CR>" : len(argv()) > 1 ? ":prev<CR>" : ":bprev<CR>"
