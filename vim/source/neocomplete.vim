let g:neocomplete#enable_at_startup = 1

" inoremap <expr><TAB> pumvisible() ? neocomplete#close_popup() : "\<TAB>"
inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1
augroup neocompletebuffers
    autocmd!
    autocmd FileType markdown NeoCompleteLock
augroup END
