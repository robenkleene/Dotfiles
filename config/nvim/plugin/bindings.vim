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
nnoremap <localleader>w :set wrap!<CR>
nnoremap <leader>w :set wrap!<CR>
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
inoremap <expr> <C-y> pumvisible() ? "\<C-y>" : "<C-u>:Cwise<CR><C-r>0"
snoremap <expr> <C-y> ":Cwise<CR>\"0p"
nnoremap <expr> <C-y> ":Cwise<CR>\"0p"
vnoremap <expr> <C-y> ":<C-u>Cwise<CR>gv\"0p"
cnoremap <expr> <C-y> len(getreg('*')) ? "<C-r>*" : "<C-r>0"
