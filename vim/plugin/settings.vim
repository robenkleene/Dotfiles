" Backtick expansion doesn't work with fish
set shell=zsh

" Enable the `:Man` command
" Note this just uses `-complete=shellcmd`
" runtime ftplugin/man.vim

" `I`: Don't show intro message
set shortmess+=I
" Hide tildes the tildes below line numbers
set fillchars+=eob:\ 
" Use a vertical bar to separate windows
set fillchars+=vert:\▏
" Line numbers
set number
" Mouse
set mouse=a
" Show key presses in lower right
set showcmd

" Add hyphen to word characters, this shouldn't be set as a default and
" instead be set per filetype
" set iskeyword+=-

" Preview from a `netrw` buffer always works like this
" set splitbelow
" set splitright

" Use system clipboard
" Delibrately ommitted because the custom clipboard `augroup` handles the
" clipboard (and also supports `tmux`). Also having this causes line breaks to
" be misshandled when copying lines (e.g., `yy`)
" New strategy is to not use system clipboard with `safecopy` and instead just
" use Vim's system clipboard support, which will automatically integrate with
" the numbered registers so that pasting from the system clipboard over a
" visual selection doesn't lose the system clipboard, which it does with the
" `safecopy` based system
" Actually setting clipboard this way doesn't use number registers either
" set clipboard^=unnamed,unnamedplus
" Autocomplete max height

" Adding [, ] to `isfname` makes URLs that have brackets work with `gx`
set isfname+=[,]
" Remove `.h` from suffixes, this prevents header files from being sorted at 
" the bottom in `netrw`
set suffixes-=.h

" `cursorline` makes it easier to see which line a search match is on when in
" the quickfix window
" The default style of this isn't very visible anyway, and can make the
" current line harder to read
" With `iceberg`, this breaks comparing two buffers
" with `:windo diffthis`
set cursorline
" Highlight just the line number
set cursorlineopt=number
