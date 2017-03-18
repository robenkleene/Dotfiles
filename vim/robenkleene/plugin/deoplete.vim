let g:deoplete#enable_at_startup = 1

let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'tag', 'file', 'ultisnips']

" " Delay Before Popup Displays
" let g:deoplete#enable_cursor_hold_i = 1
" let g:deoplete#cursor_hold_i_time = 100
" Autoselect the first match (otherwise down arrow needs to be entered)
set completeopt+=noinsert

" By default `deoplete` uses `<CR>` to accept the completion. But this makes
" it difficult to create a new line with a partial completion. `<TAB>` is a
" better key to accept the completion, because, in programming, you almost 
" never need to insert a tab after the start of a line.
" inoremap <expr><TAB> pumvisible() ? deoplete#close_popup() : "\<TAB>"
inoremap <expr><CR> deoplete#smart_close_popup()."\<CR>"
" <C-f> is defined in `./plugin/deoplete.vim`

" Disable for some filetypes
augroup deoplete_buffers
  autocmd!
  autocmd FileType markdown let b:deoplete_disable_auto_complete=1
augroup END
