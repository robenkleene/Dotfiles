" 'If your plugin makes character-level changes to the buffer, it probably
" deserves a map or two.' --Tim Pope

" Web Search
nnoremap <silent> <localleader>S :set opfunc=operators#WebSearch<CR>g@
vnoremap <silent> <localleader>S :<C-U>call operators#WebSearch(visualmode(), 1)<CR>

" Title Case
nnoremap <silent> <localleader>c :set opfunc=operators#TitleCase<CR>g@
vnoremap <silent> <localleader>c :<C-U>call operators#TitleCase(visualmode(), 1)<CR>

" Markwodn Wiki Link
nnoremap <silent> <localleader>k :set opfunc=operators#MarkdownWikiLink<CR>g@
vnoremap <silent> <localleader>k :<C-U>call operators#MarkdownWikiLink(visualmode(), 1)<CR>

" Open URLs
nnoremap <silent> <localleader>L :set opfunc=operators#OpenURLs<CR>g@
vnoremap <silent> <localleader>L :<C-U>call operators#OpenURLs(visualmode(), 1)<CR>

" Archive Text
nnoremap <silent> <localleader>a :set opfunc=operators#Archive<CR>g@
vnoremap <silent> <localleader>a :<C-U>call operators#Archive(visualmode(), 1)<CR>

" Archive & Delete Text
nnoremap <silent> <localleader>d :set opfunc=operators#ArchiveAndDelete<CR>g@
vnoremap <silent> <localleader>d :<C-U>call operators#ArchiveAndDelete(visualmode(), 1)<CR>

