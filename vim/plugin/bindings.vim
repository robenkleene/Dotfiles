nnoremap Y y$

" nvim already has custom clipboard support
if !has('clipboard') && !has('!nvim')
  nnoremap <silent> "*p "=system('~/.bin/safepaste')<CR>p
  vnoremap <silent> "*p "=system('~/.bin/safepaste')<CR>p
  nnoremap <silent> "+p "=system('~/.bin/safepaste')<CR>p
  vnoremap <silent> "+p "=system('~/.bin/safepaste')<CR>p
  nnoremap <silent> "*P "=system('~/.bin/safepaste')<CR>P
  vnoremap <silent> "*P "=system('~/.bin/safepaste')<CR>P
  nnoremap <silent> "+P "=system('~/.bin/safepaste')<CR>P
  vnoremap <silent> "+P "=system('~/.bin/safepaste')<CR>P
  cnoremap <silent> <C-r>* <C-r>=system('~/.bin/safepaste')<CR>
  inoremap <silent> <C-r>* <C-r>=system('~/.bin/safepaste')<CR>
  cnoremap <silent> <C-r>+ <C-r>=system('~/.bin/safepaste')<CR>
  inoremap <silent> <C-r>+ <C-r>=system('~/.bin/safepaste')<CR>
  " Make these `<Nop>` so the `"` register is used for yanks, which the
  " `TextYankPost` will then pickup
  nnoremap <silent> "* <Nop>
  vnoremap <silent> "* <Nop>
  nnoremap <silent> "+ <Nop>
  vnoremap <silent> "+ <Nop>
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
