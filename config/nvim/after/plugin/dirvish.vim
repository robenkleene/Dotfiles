augroup dirvish_mapping
    autocmd!
    autocmd filetype dirvish call s:DirvishMapping()
augroup END

function! s:DirvishMapping()
  nnoremap <silent><buffer> cd <Nop>
  nnoremap <silent><buffer> / /
  nnoremap <silent><buffer> ? ?
endfunction
