" For state restoration
" set viewoptions-=options
" Prevent restoring view from changing the current working directory
set viewoptions-=curdir
" This prevents opening new files with folds being restored, it does not
" affect opening a file with folds then navigating away and back to that same
" file
set viewoptions-=folds
set sessionoptions-=curdir
" set viewoptions-=blank
set sessionoptions-=folds
" `options` and `localoptions` in `sessionoptions` makes changing settings in
" `vimrc` then reloading the session load the old settings
set sessionoptions-=options
set sessionoptions-=localoptions
" Don't reload blank windows (there contents will be missing anyway)
set sessionoptions-=blank
