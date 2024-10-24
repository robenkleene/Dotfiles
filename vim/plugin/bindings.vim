nnoremap Y y$

" Instead of using these custom bindings for working with the quickfix list
" quickly, use the corresponding fuzzy finders, which allow going through the
" list with one key stroke in a more conventional way.
" Add `zv` to quickfix bindings to show the cursor line, because these
" bindings don't respect the `foldopen` option
" (This solution is from `unimpaired`)
nnoremap <expr> <M-p> len(getqflist()) ? ":cprev<CR>zv" : len(argv()) > 1 ? ":prev<CR>" : ":bprev<CR>"
nnoremap <expr> <M-n> len(getqflist()) ? ":cnext<CR>zv" : len(argv()) > 1 ? ":next<CR>" : ":bnext<CR>"
"nnoremap <silent> <leader>q :call bindings#ToggleQuickfixList()<CR>

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

" Move by display line
nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> <Up> gk
nnoremap <silent> <Down> gj
