augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call s:NetrwMapping()
augroup END

" Override Netrw's own bindings
function! s:NetrwMapping()
  nnoremap <buffer> <silent> <S-Left> :TmuxNavigateLeft<cr>
  nnoremap <buffer> <silent> <S-Down> :TmuxNavigateDown<cr>
  nnoremap <buffer> <silent> <S-Up> :TmuxNavigateUp<cr>
  nnoremap <buffer> <silent> <S-Right> :TmuxNavigateRight<cr>
endfunction

" Disable netrw's built-in support
autocmd! Network BufReadCmd file://*
augroup follow_file_links
  autocmd!
  autocmd BufReadCmd file:///* exe "edit /".substitute(expand("<afile>"),"file:/*","","")
  " The bd destroys the broken buffer it opened
  " autocmd BufReadCmd file:///* exe "bd!|edit /".substitute(expand("<afile>"),"file:/*","","")
augroup END
