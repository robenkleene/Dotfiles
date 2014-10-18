" This method doesn't require saving to a file but the result doesn't handle '\'
" to break long lines
" command! RunVimscript :silent exe '%y"'|:@"<CR>
command! RunVimscript :update | :source %
nnoremap <leader>r :RunVimscript<CR>
