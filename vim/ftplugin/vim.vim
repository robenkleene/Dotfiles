" " This method doesn't require saving to a file but the result doesn't handle '\'
" " to break long lines
" " command! RunVimscript :silent exe '%y"'|:@"<CR>
" command! RunVimscript :update | :source %
" nnoremap <leader>r :RunVimscript<CR>

" " Just yanking the text and running `:@` is an easy way to do this
" " vnoremap <leader>vs y:@"<CR>
" command! RunVimscriptVisual :yank a | @a
" vnoremap <leader>r :<C-u>RunVimscriptVisual<CR>
