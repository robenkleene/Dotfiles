if !has('lua')
  finish
end

inoremap <expr><C-g> pumvisible() ? neocomplete#cancel_popup() : "\<ESC>"
inoremap <expr><TAB> pumvisible() ? neocomplete#close_popup() : "\<TAB>"
inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
" This doesn't work here because `rsi.vim` overrides this binding
" inoremap <expr><C-f> pumvisible() ? neocomplete#close_popup() : "\<C-f>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Disable for some filetypes
augroup neocomplete_buffers
  autocmd!
  autocmd FileType markdown NeoCompleteLock
augroup END
