let g:neocomplete#enable_at_startup = 1

inoremap <expr><C-g> pumvisible() ? neocomplete#cancel_popup() : "\<ESC>"
inoremap <expr><TAB> pumvisible() ? neocomplete#close_popup() : "\<TAB>"
inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
inoremap <expr><C-f> pumvisible() ? neocomplete#close_popup() : "\<C-f>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Delay Before Popup Displays
let g:neocomplete#enable_cursor_hold_i = 1
let g:neocomplete#cursor_hold_i_time = 500

" Autoselect matches (don't have to use arrows)
let g:neocomplete#enable_auto_select = 1

" Disable for some filetypes
augroup neocomplete_buffers
  autocmd!
  autocmd FileType markdown NeoCompleteLock
augroup END
