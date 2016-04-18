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
