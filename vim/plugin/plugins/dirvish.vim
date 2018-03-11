
augroup dirvish_config
  autocmd!
  autocmd FileType dirvish nnoremap <silent><buffer>gh :<C-u>DirvishToggleHidden<CR>:Dirvish %<CR>
  " Dirvish maps these for the following reason, probably a mistake to unmap
  " but I find them ugly
  " "Buffer-local / and ? mappings to skip the concealed path fragment."
  autocmd FileType dirvish nunmap <buffer> /
  autocmd FileType dirvish nunmap <buffer> ?
augroup END

command! DirvishToggleHidden call <SID>ToggleHidden()

function! s:ToggleHidden() abort
  if exists("g:dirvish_mode")
    unlet g:dirvish_mode
  else
    let g:dirvish_mode = ':silent keeppatterns g@\v/\.[^\/]+/?$@d _'
  endif
endfunction

" Default to hidden
call <SID>ToggleHidden()
