" nnoremap <leader>A :Ag 
nnoremap <leader>A :AgCurrent 
nnoremap <leader>a :AgProject 

command! -bang -nargs=* -complete=file AgProject 
      \ let g:ag_working_path_mode = 'r' |
      \ call ag#Ag('grep<bang>',<q-args>)

command! -bang -nargs=* -complete=file AgCurrent
      \ let g:ag_working_path_mode = 'c' |
      \ call ag#Ag('grep<bang>',<q-args>)
