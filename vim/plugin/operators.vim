" 'If your plugin makes character-level changes to the buffer, it probably
" deserves a map or two.' --Tim Pope
nnoremap <silent> <localleader>G :set opfunc=operators#Google<CR>g@
vnoremap <silent> <localleader>G :<C-U>call operators#Google(visualmode(), 1)<CR>

" Titlecase
nnoremap <silent> <localleader>t :set opfunc=operators#TitleCase<CR>g@
vnoremap <silent> <localleader>t :<C-U>call operators#TitleCase(visualmode(), 1)<CR>
