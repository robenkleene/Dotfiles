nnoremap Y y$

" Add `zv` to quickfix bindings to show the cursor line, because these
" bindings don't respect the `foldopen` option
" (This solution is from `unimpaired`)
nnoremap <expr> <M-p> len(getqflist()) ? ":cprev<CR>zv" : len(argv()) > 1 ? ":prev<CR>" : ":bprev<CR>"
nnoremap <expr> <M-n> len(getqflist()) ? ":cnext<CR>zv" : len(argv()) > 1 ? ":next<CR>" : ":bnext<CR>"

nnoremap <silent> " :let @t=system('~/.bin/safepaste')<CR>"
cnoremap <expr> <silent> <C-r> <SID>RegisterCopyPaste()
inoremap <expr> <silent> <C-r> <SID>RegisterCopyPaste()

function! s:RegisterCopyPaste()
  let @t=system('~/.bin/safepaste')
  return "\<C-r>"
endfunction
