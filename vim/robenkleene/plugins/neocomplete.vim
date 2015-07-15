let g:neocomplete#enable_at_startup = 1

inoremap <expr><C-g> pumvisible() ? neocomplete#cancel_popup() : "\<ESC>"
inoremap <expr><TAB> pumvisible() ? neocomplete#close_popup() : "\<TAB>"
inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Autoselect matches (don't have to use arrows)
let g:neocomplete#enable_auto_select = 1

" Disable for some filetypes
augroup neocomplete_buffers
	autocmd!
	autocmd FileType markdown NeoCompleteLock
augroup END
