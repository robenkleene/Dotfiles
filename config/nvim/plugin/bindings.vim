" nnoremap <silent> <leader>oi :OI<CR>
nnoremap <silent> cl :lcd %:p:h<CR>:echo getcwd()<CR>
nnoremap <silent> cd :cd %:p:h<CR>:echo getcwd()<CR>
nnoremap <silent> cg :execute 'cd' getcwd(-1)<CR>:echo getcwd()<CR>
nnoremap <expr> <M-n> len(getqflist()) ? ":cn<CR>" : len(argv()) > 1 ? ":next<CR>" : ":Fnext<CR>"
nnoremap <expr> <M-p> len(getqflist()) ? ":cp<CR>" : len(argv()) > 1 ? ":prev<CR>" : ":Fprev<CR>"
" Move by display line
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> <up> gk
noremap <silent> <down> gj
nnoremap <A-left> b
nnoremap <A-right> w

" Quickfix
nnoremap <leader>q :call bindings#ToggleQuickfixList()<CR>
nnoremap <leader>cq :GrepBufferFromClipboard<CR>
nnoremap <leader>* :Rg <C-r><C-w><cr>
vnoremap <leader>* :<C-u>call bindings#RgVisual()<CR>
" Other
nnoremap <localleader>yb :YankBreakpoint<CR>
nnoremap <localleader>w :set wrap!<CR>
nnoremap <leader>w :set wrap!<CR>
nnoremap <leader>` :terminal<CR>
" Tabs
nnoremap <silent> <C-w>t :split<CR><C-w>T
vnoremap <silent> <C-w>t :split<CR><C-w>T
nnoremap <silent> <C-w>q :tabclose<CR>
vnoremap <silent> <C-w>q :<C-u>tabclose<CR>
nnoremap <C-w>n gt
nnoremap <C-w>p gT
vnoremap <C-w>n gt
vnoremap <C-w>p gT
" Command Line
cnoremap <C-A> <Home>
cnoremap <M-BS> <C-W>
cnoremap <A-left> <S-Left>
cnoremap <A-right> <S-Right>
" Insert
inoremap <M-BS> <C-W>
" Other
nnoremap <silent> <M-r> :silent !open -R "%:p"<CR>\|:redraw!<CR>
" Paste
" We need to be able to paste from both the `*` register and the `0` register:
" 1. We use `*` when yanking and then pasting in insert mode
" 2. We use `0` when pasting with a visual selection multiple times
inoremap <expr> <C-y> pumvisible() ? "\<C-y>" : "<C-o>:<C-u>Cwise<CR><C-r>*"
snoremap <expr> <C-y> ":Cwise<CR>p"
nnoremap <expr> <C-y> ":Cwise<CR>p"
vnoremap <expr> <C-y> ":<C-u>Cwise<CR>gvp"
cnoremap <expr> <C-y> "<C-r>*"
inoremap <expr> <M-y> pumvisible() ? "\<C-y>" : "<C-o>:<C-u>Cwise<CR><C-r>0"
snoremap <expr> <M-y> ":Cwise<CR>\"0p"
nnoremap <expr> <M-y> ":Cwise<CR>\"0p"
vnoremap <expr> <M-y> ":<C-u>Cwise<CR>gv\"0p"
cnoremap <expr> <M-y> "<C-r>0"
