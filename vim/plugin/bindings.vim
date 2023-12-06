nnoremap Y yg_

nnoremap <localleader>yg :YankGrep<CR>
nnoremap <silent> <M-r> :silent !open -R "%:p"<CR>\|:redraw!<CR>

" Use visual line unless there's a <vcount>
" This is preferrable because otherwise it's not clear what will happen when
" navigating up or down with wrap on without looking at the line numbers at
" the beginning of the line.
" This breaks entering snippets, e.g., if you start a snippet, and are at the
" first `$1`, if you type `j` it will mess up instead of entering `j`
noremap <expr> k v:count ? 'k' : 'gk'
noremap <expr> j v:count ? 'j' : 'gj'
noremap <expr> <Up> v:count ? 'k' : 'gk'
noremap <expr> <Down> v:count ? 'j' : 'gj'
