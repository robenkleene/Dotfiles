augroup dirvish_mapping
    autocmd!
    autocmd filetype dirvish call s:DirvishMapping()
augroup END

function! s:DirvishMapping()
  noremap <silent><buffer> cd <Nop>
endfunction
