nnoremap <leader>oi :cd ~/Developer/Dotfiles/config/nvim/<CR>:edit init.lua<CR>:echo ""<CR>
nnoremap cl :lcd %:p:h<CR>
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
nnoremap <C-w>t :split<CR><C-w>T
vnoremap <C-w>t :split<CR><C-w>T
nnoremap <C-w>q :tabclose<CR>
vnoremap <C-w>q :<C-u>tabclose<CR>
nnoremap <C-w>n gt
nnoremap <C-w>p gT
vnoremap <C-w>n gt
vnoremap <C-w>p gT
" Clipboard
nnoremap <space>p "*p
nnoremap <space>P "*P
vnoremap <space>p "*p
vnoremap <space>P "*P
nnoremap <space>y "*y
vnoremap <space>y "*y
" Command Line
cnoremap <C-A> <Home>
" cnoremap <expr> <C-y> len(getreg('*')) ? "<C-r>*" : "<C-r>0"
cnoremap <expr> <C-v> len(getreg('*')) ? "<C-r>*" : "<C-r>0"
cnoremap <M-BS> <C-W>
cnoremap <A-left> <S-Left>
cnoremap <A-right> <S-Right>
" Insert
" inoremap <expr> <C-y> pumvisible() ? "\<C-y>" : len(getreg('*')) ? "<C-r>*" : "<C-r>0"
inoremap <expr> <C-v> pumvisible() ? "\<C-y>" : len(getreg('*')) ? "<C-r>*" : "<C-r>0"
inoremap <M-BS> <C-W>
" Other
nnoremap <M-r> :silent !open -R "%:p"<CR>\|:redraw!<CR>
