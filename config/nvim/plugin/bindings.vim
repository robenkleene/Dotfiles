nnoremap <silent> <leader>oi :cd ~/Developer/Dotfiles/config/nvim/<CR>:edit init.lua<CR>
nnoremap <silent> cl :lcd %:p:h<CR>
nnoremap <silent> cd :cd %:p:h<CR>
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
" cnoremap <expr> <C-y> len(getreg('*')) ? "<C-r>*" : "<C-r>0"
cnoremap <expr> <C-v> len(getreg('*')) ? "<C-r>*" : "<C-r>0"
cnoremap <M-BS> <C-W>
cnoremap <A-left> <S-Left>
cnoremap <A-right> <S-Right>
" Insert
inoremap <M-BS> <C-W>
" Other
nnoremap <silent> <M-r> :silent !open -R "%:p"<CR>\|:redraw!<CR>
