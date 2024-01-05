nnoremap <silent> <localleader>yg :set opfunc=operators#GrepYank<CR>g@
vnoremap <silent> <localleader>yg :<C-U>call operators#GrepYank(visualmode(), 1)<CR>
