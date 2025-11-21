nnoremap Y y$

" nnoremap ZX :%y*\|q!<CR>
" This yanks without the trailing new line
nnoremap ZX :let @* = join(getline(1,'$'), "\n")\|q!<CR>

" Instead of using these custom bindings for working with the quickfix list
" quickly, use the corresponding fuzzy finders, which allow going through the
" list with one key stroke in a more conventional way.
" Add `zv` to quickfix bindings to show the cursor line, because these
" bindings don't respect the `foldopen` option
" (This solution is from `unimpaired`)
"nnoremap <silent><expr> <M-p> len(getqflist()) ? ":cprev<CR>zv" : len(argv()) > 1 ? ":prev<CR>" : ":bprev<CR>"
"nnoremap <silent><expr> <M-n> len(getqflist()) ? ":cnext<CR>zv" : len(argv()) > 1 ? ":next<CR>" : ":bnext<CR>"
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
" When preceeded with a number, use the normal binding (e.g., `4j` will jump
" down four wrapped lines)
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> <silent> <Up> (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> <silent> <Down> (v:count == 0 ? 'gj' : 'j')
" `xnoremap` only applies to visual mode, whereas `vnoremap` applies to both
" visual mode and select mode. Select mode will mess with filling out snippet
" stops.
xnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
xnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
xnoremap <expr> <silent> <Up> (v:count == 0 ? 'gk' : 'k')
xnoremap <expr> <silent> <Down> (v:count == 0 ? 'gj' : 'j')

" Unimpaired conflict markers
nnoremap <silent> [n :<C-U>call bindings#Context(1)<CR>
onoremap <silent> [n :<C-U>call bindings#ContextMotion(1)<CR>
xnoremap <silent> [n :<C-U>exe 'normal! gv'<Bar>call bindings#Context(1)<CR>
nnoremap <silent> ]n :<C-U>call bindings#Context(0)<CR>
xnoremap <silent> ]n :<C-U>exe 'normal! gv'<Bar>call bindings#Context(0)<CR>
onoremap <silent> ]n :<C-U>call bindings#ContextMotion(0)<CR>
