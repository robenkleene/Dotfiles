" Backtick expansion doesn't work with fish
set shell=zsh

" Settings
set shortmess+=atI
" Hide tilde for lines not in buffer
set fillchars=eob:\ 
set number
set mouse=a

" Indent wrapped lines
set breakindent

" Smartcase
set ignorecase
set smartcase

" Highlight search results
set hlsearch
" Don't display saved search highlights on startup
nohlsearch

set iskeyword+=-
set splitbelow
set splitright
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set list
" Use system clipboard
" Delibrately ommitted because the custom clipboard `augroup` handles the
" clipboard (and also supports `tmux`). Also having this causes line breaks to
" be misshandled when copying lines (e.g., `yy`)
" set clipboard^=unnamed,unnamedplus
" Autocomplete max height
set pumheight=10
" Disable swap files, this allows multiple instances to edit the same file
set noswapfile
" For state restoration
" set viewoptions-=options
" set viewoptions-=folds
" set viewoptions-=curdir
" set viewoptions-=blank
" set sessionoptions-=options
" set sessionoptions-=folds
" set sessionoptions-=blank
" Prefer spaces to tabs
set expandtab
" Don't start folded
set nofoldenable
" Only complete to longest match in wildmenu
set wildmode=longest:full,full
" Show column vertical line
set colorcolumn=80
" Line breaks only happen on words
set linebreak
" Launch without wrapped lines
set nowrap
" Don't timeout leader key
set notimeout
" Don't prompt when trying to navigate to another buffer when current buffer
" is modified
set hidden

" Hide dot files in file list (`gh` to toggle in `vim-vinegar`)
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" Sort case-insensitive
let g:netrw_sort_options = "i"
" Faster `netrw` but clibpoard might get clobbered
" This doesn't seem to make a difference
" let g:netrw_clipboard = 0

set cursorline
" Highlight just the line number
" set cursorlineopt=number
