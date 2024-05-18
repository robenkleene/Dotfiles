nnoremap Y y$

" Add `zv` to quickfix bindings to show the cursor line, because these
" bindings don't respect the `foldopen` option
" (This solution is from `unimpaired`)
nnoremap <expr> <M-p> len(getqflist()) ? ":cprev<CR>zv" : len(argv()) > 1 ? ":prev<CR>" : ":bprev<CR>"
nnoremap <expr> <M-n> len(getqflist()) ? ":cnext<CR>zv" : len(argv()) > 1 ? ":next<CR>" : ":bnext<CR>"

nnoremap <silent> <leader>q :call bindings#ToggleQuickfixList()<CR>

if !has('clipboard')
  nnoremap <silent> "* "=system('~/.bin/safepaste')<CR>
  vnoremap <silent> "* "=system('~/.bin/safepaste')<CR>
  nnoremap <silent> "+ "=system('~/.bin/safepaste')<CR>
  vnoremap <silent> "+ "=system('~/.bin/safepaste')<CR>
  cnoremap <silent> <C-r>* <C-r>=system('~/.bin/safepaste')<CR>
  inoremap <silent> <C-r>* <C-r>=system('~/.bin/safepaste')<CR>
  cnoremap <silent> <C-r>+ <C-r>=system('~/.bin/safepaste')<CR>
  inoremap <silent> <C-r>+ <C-r>=system('~/.bin/safepaste')<CR>
endif

" Visual Star
" This is the default in Neovim, but the default implementation doesn't handle
" selections that include `/` correctly
vnoremap <silent> * :call setreg("/",
    \ substitute(bindings#GetSelectedText(),
    \ '\_s\+',
    \ '\\_s\\+', 'g')
    \ )<Cr>n

vnoremap <silent> # :call setreg("/", 
    \ substitute(bindings#GetSelectedText(),
    \ '\_s\+',
    \ '\\_s\\+', 'g')
    \ )<Bar>let v:searchforward = 0<Cr>n

cnoremap <M-left> <S-left>
inoremap <M-left> <S-left>
cnoremap <M-right> <S-right>
inoremap <M-right> <S-right>

" Move by display line
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> <Up> gk
noremap <silent> <Down> gj
