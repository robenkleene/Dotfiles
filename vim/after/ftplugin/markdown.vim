" Use visual line unless there's a <vcount>
" This is preferrable because otherwise it's not clear what will happen when
" navigating up or down with wrap on without looking at the line numbers at
" the beginning of the line.
" This breaks entering snippets, e.g., if you start a snippet, and are at the
" first `$1`, if you type `j` it will mess up instead of entering `j`
noremap <buffer> <expr> k v:count ? 'k' : 'gk'
noremap <buffer> <expr> j v:count ? 'j' : 'gj'
noremap <buffer> <expr> <Up> v:count ? 'k' : 'gk'
noremap <buffer> <expr> <Down> v:count ? 'j' : 'gj'

" Allow moving past the first character on the line, this makes editing prose
" easier
" <,> are arrow keys in normal and visual modes
" [,] are arrow keys in insert mode
" setlocal whichwrap+=h,l,<,>,[,]
