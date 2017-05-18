nnoremap <leader>g :Git 

" cnoreabbrev Gs Gstatus

" augroup git_commands
"   autocmd!
"   autocmd FileType * nnoremap <buffer> <localleader>gd :Git diff "%"<CR>
"   autocmd FileType gitcommit nnoremap <buffer> <localleader>gd :Git diff<CR>
" augroup END
