nnoremap <silent> <localleader>g :set opfunc=operators#GrepYank<CR>g@
vnoremap <silent> <localleader>g :<C-U>call operators#GrepYank(visualmode(), 1)<CR>
