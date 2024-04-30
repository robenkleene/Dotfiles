nnoremap Y y$

" Add `zv` to quickfix bindings to show the cursor line, because these
" bindings don't respect the `foldopen` option
" (This solution is from `unimpaired`)
nnoremap <silent> <M-p> :cprev<CR>zv
nnoremap <silent> <M-n> :cnext<CR>zv

nnoremap <silent> " :let @t=system('~/.bin/safepaste')<CR>"
cnoremap <expr> <silent> <C-r> <SID>RegisterCopyPaste()
inoremap <expr> <silent> <C-r> <SID>RegisterCopyPaste()

function! s:RegisterCopyPaste()
  let @t=system('~/.bin/safepaste')
  return "\<C-r>"
endfunction
