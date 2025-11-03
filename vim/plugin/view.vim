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
" Removing this because setting `makeprg` definitely should be preserved
" between sessions
" Note this `set sessionoptions-=options` is also set by `sensible.vim`
" set sessionoptions-=options
" set sessionoptions-=localoptions

" Don't reload blank windows (the contents of these windows will be missing
" anyway)
set sessionoptions-=blank
