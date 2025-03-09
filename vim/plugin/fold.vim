" Don't start folded
" Only toggle on folds for buffer local for file types where it's useful, too
" irritating trying to keep files opening unfolded otherwise
"set nofoldenable
" If this is set, then having a buffer with folds, jumping to a tag, then
" returning to the original file, will open folds
" set foldlevelstart=99
" Just `foldlevelstart` doesn't catch everything for some reason
set foldlevel=99
" Default to foldmethod indent because that always works (the default is
" `manual`)
set foldmethod=indent
" Don't let search open folds (useful for determining if a term appears in
" un-folded text)
" Make folds sticky
" Set what opens folds
" In general we open folds when navigating across files, but keep them closed
" in the current file
" This makes it easy to set folds and then just navigate the unfolded content
" E.g., it lets us focus only on on folded content within the file
" Exclude search, this makes it easy to search just changed contents in
" `vimdiff` (because all unchanged content will be folded)
set foldopen-=search
" Horizontal movements
" Really no reason not to keep this option, since without it horizontal movement keys
" (i.e., `h`, `l`) do nothing
set foldopen-=hor
set foldopen-=jump
set foldopen-=block
set foldopen-=percent

" Without this, jumping to a symbol and back will open the current fold
" (because a mark is set before jumping)
set foldopen-=mark
" Jumping to a fold in quickfix list should open.
" This will mean that `vimgrep <term> %` can't be used to jump to matches that
" aren't in folds (there doesn't seem to be much advantage over just using `/`
" search for this?)
" set foldopen-=quickfix
" Definitely should fold open when jumping to definition
" set foldopen-=tag
