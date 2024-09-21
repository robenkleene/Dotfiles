nnoremap Y y$

" Instead of using these custom bindings for working with the quickfix list
" quickly, use the corresponding fuzzy finders, which allow going through the
" list with one key stroke in a more conventional way.
" Add `zv` to quickfix bindings to show the cursor line, because these
" bindings don't respect the `foldopen` option
" (This solution is from `unimpaired`)
"nnoremap <expr> <M-p> len(getqflist()) ? ":cprev<CR>zv" : len(argv()) > 1 ? ":prev<CR>" : ":bprev<CR>"
"nnoremap <expr> <M-n> len(getqflist()) ? ":cnext<CR>zv" : len(argv()) > 1 ? ":next<CR>" : ":bnext<CR>"
"nnoremap <silent> <leader>q :call bindings#ToggleQuickfixList()<CR>

" nvim already has custom clipboard support
" For some reason the `!has('nvim')` check has to be before the
" `!has('clipboard')` check otherwise this breaks clipboard integration in
" Neovim (yes that makes no sense)
if !has('nvim') && !has('clipboard')
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

" Readline
cnoremap <M-left> <S-left>
inoremap <M-left> <S-left>
cnoremap <M-right> <S-right>
inoremap <M-right> <S-right>

" Move by display line
nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> <Up> gk
nnoremap <silent> <Down> gj
