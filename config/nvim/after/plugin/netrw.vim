augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call s:NetrwMapping()
augroup END

function! s:NetrwMapping()
  noremap <silent><buffer> cdg :execute "cd ".fnameescape(b:netrw_curdir)<CR>\|:redraw!<CR>
  noremap <silent><buffer> cdl :execute "lcd ".fnameescape(b:netrw_curdir)<CR>\|:redraw!<CR>
endfunction
