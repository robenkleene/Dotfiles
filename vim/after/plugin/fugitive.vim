augroup git_commands
  autocmd!
  autocmd FileType * nnoremap <buffer> <localleader>gd :Git diff "%"<CR>
  autocmd FileType gitcommit nnoremap <buffer> <localleader>gd :Git diff<CR>
augroup END

nnoremap <leader>gs :Gstatus<CR>
