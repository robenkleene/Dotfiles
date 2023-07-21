nnoremap Y yg_
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
" noremap <silent> <up> gk
" noremap <silent> <down> gj

" Quickfix
nnoremap <leader>q :call bindings#ToggleQuickfixList()<CR>
nnoremap <leader>* :Rg <C-r><C-w><cr>
vnoremap <leader>* :<C-u>call bindings#RgVisual()<CR>
" Other
nnoremap <localleader>yg :YankGrep<CR>
nnoremap <localleader>w :set wrap!<CR>
" Tabs
nnoremap <silent> <C-w>t :tabnew<CR>
nnoremap <silent> <C-w>q :tabclose<CR>
vnoremap <silent> <C-w>q :<C-u>tabclose<CR>
" Paste
snoremap <localleader>p :Cwise<CR>"0p
nnoremap <localleader>p :Cwise<CR>"0p
vnoremap <localleader>p :<C-u>Cwise<CR>gv"0p
snoremap <localleader>P :Cwise<CR>"0P
nnoremap <localleader>P :Cwise<CR>"0P
vnoremap <localleader>P :<C-u>Cwise<CR>gv"0P
" Other
nnoremap <silent> <M-r> :silent !open -R "%:p"<CR>\|:redraw!<CR>
