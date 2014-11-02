set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim']

" Opening from the finder doesn't trigger BufWinEnter
augroup OSXAutoView
    autocmd!
    " Autosave & Load Views.
    autocmd BufRead ?* if MakeViewCheck() | silent! loadview | endif
augroup END
