" nnoremap <silent> <leader>oi :OI<CR>
" Can't use `cl` here because it conflicts with "changing" current char plus
" one right
nnoremap <silent> cdl :lcd %:p:h<CR>:echo getcwd()<CR>
nnoremap <silent> cdg :cd %:p:h<CR>:echo getcwd()<CR>
nnoremap <silent> cdp :execute 'cd' getcwd(-1)<CR>:echo getcwd()<CR>
nnoremap <expr> <M-n> len(getqflist()) ? ":cn<CR>" : len(argv()) > 1 ? ":next<CR>" : ":Fnext<CR>"
nnoremap <expr> <M-p> len(getqflist()) ? ":cp<CR>" : len(argv()) > 1 ? ":prev<CR>" : ":Fprev<CR>"
" Move by display line
" This breaks entering snippets, e.g., if you start a snippet, and are at the
" first `$1`, if you type `j` it will mess up instead of entering `j`
" noremap <silent> k gk
" noremap <silent> j gj
noremap <silent> <up> gk
noremap <silent> <down> gj
nnoremap <A-left> b
nnoremap <A-right> w

" Quickfix
nnoremap <leader>q :call bindings#ToggleQuickfixList()<CR>
nnoremap <leader>* :Rg <C-r><C-w><cr>
vnoremap <leader>* :<C-u>call bindings#RgVisual()<CR>
" Other
nnoremap <leader>yg :YankGrep<CR>
nnoremap <localleader>w :set wrap!<CR>
nnoremap <leader>w :set wrap!<CR>
nnoremap <leader>T :terminal<CR>
nnoremap <leader>t :TerminalLocal<CR>
" Tabs
nnoremap <silent> <C-w>t :split<CR><C-w>T
vnoremap <silent> <C-w>t :split<CR><C-w>T
nnoremap <silent> <C-w>q :tabclose<CR>
vnoremap <silent> <C-w>q :<C-u>tabclose<CR>
nnoremap <C-w>n gt
nnoremap <C-w>p gT
vnoremap <C-w>n gt
vnoremap <C-w>p gT
" Paste
snoremap <expr> <leader>p ":Cwise<CR>\"0p"
nnoremap <expr> <leader>p ":Cwise<CR>\"0p"
vnoremap <expr> <leader>p ":<C-u>Cwise<CR>gv\"0p"
" Other
nnoremap <silent> <M-r> :silent !open -R "%:p"<CR>\|:redraw!<CR>
nnoremap _ :NNN<CR>
