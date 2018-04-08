" 'If your plugin makes character-level changes to the buffer, it probably
" deserves a map or two.' --Tim Pope

" Web Search
nnoremap <silent> <localleader>S :set opfunc=operators#WebSearch<CR>g@
vnoremap <silent> <localleader>S :<C-U>call operators#WebSearch(visualmode(), 1)<CR>

" Titlecase
nnoremap <silent> <localleader>t :set opfunc=operators#TitleCase<CR>g@
vnoremap <silent> <localleader>t :<C-U>call operators#TitleCase(visualmode(), 1)<CR>

" Open URLs
nnoremap <silent> <localleader>L :set opfunc=operators#OpenURLs<CR>g@
vnoremap <silent> <localleader>L :<C-U>call operators#OpenURLs(visualmode(), 1)<CR>
