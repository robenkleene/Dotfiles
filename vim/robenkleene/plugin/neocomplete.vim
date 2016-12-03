let g:neocomplete#enable_at_startup = 1

" Delay Before Popup Displays
let g:neocomplete#enable_cursor_hold_i = 1
let g:neocomplete#cursor_hold_i_time = 100

" Autoselect the first match (otherwise down arrow needs to be entered)
let g:neocomplete#enable_auto_select = 1

" By default `neocomplete` uses `<CR>` to accept the completion. But this makes
" it difficult to create a new line with a partial completion. `<TAB>` is a
" better key to accept the completion, because, in programming, you almost 
" never need to insert a tab after the start of a line.
inoremap <expr><TAB> pumvisible() ? neocomplete#close_popup() : "\<TAB>"
inoremap <expr><CR> neocomplete#smart_close_popup()."\<CR>"

" Disable for some filetypes
augroup neocomplete_buffers
  autocmd!
  autocmd FileType markdown NeoCompleteLock
augroup END
