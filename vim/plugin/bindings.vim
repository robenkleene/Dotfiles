nnoremap Y y$

" Add `zv` to quickfix bindings to show the cursor line, because these
" bindings don't respect the `foldopen` option
" (This solution is from `unimpaired`)
nnoremap <expr> <M-p> len(getqflist()) ? ":cprev<CR>zv" : len(argv()) > 1 ? ":prev<CR>" : ":bprev<CR>"
nnoremap <expr> <M-n> len(getqflist()) ? ":cnext<CR>zv" : len(argv()) > 1 ? ":next<CR>" : ":bnext<CR>"

nnoremap <silent> <leader>q :call bindings#ToggleQuickfixList()<CR>

nnoremap <silent> " :let @t=system('~/.bin/safepaste')<CR>"
vnoremap <silent> " :<C-u>let @t=system('~/.bin/safepaste')<CR>gv"
cnoremap <expr> <silent> <C-r> bindings#RegisterCopyPaste()
inoremap <expr> <silent> <C-r> bindings#RegisterCopyPaste()

cnoremap <M-left> <S-left>
inoremap <M-left> <S-left>
cnoremap <M-right> <S-right>
inoremap <M-right> <S-right>
