" Backtick expansion doesn't work with fish
set shell=zsh

" Enable the `:Man` command
runtime ftplugin/man.vim

" `I`: Don't show intro message
set shortmess+=I
" Hide tildes the tildes below line numbers
set fillchars=eob:\ 
" Line numbers
set number
" Mouse
set mouse=a
" Show key presses in lower left
set showcmd

" Indent wrapped lines
set breakindent

" Allow yanks to be repeated with `.`
set cpoptions+=y

" Smartcase
" Without this, a lowercase search will not match words with uppercase
" letters, even if `smartcase` is on
" set ignorecase
" Just use `\c` to make search case insensitive
" set smartcase

" Indent
" When opening lines, make it the same indent level as the current line
set autoindent
" Indent blocks (e.g., after a `{`) automatically
set smartindent

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
" Prevent restoring view from changing the current working directory
set viewoptions-=curdir
set sessionoptions-=curdir
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
" Use a vertical wildmenu
" set wildoptions=pum
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
" This causes the `%` register to not be set when opening a directory, e.g.,
" `vim .` the `%` register won't be set and `cd %` will fail
" set hidden

" Hide dot files in file list (`gh` to toggle in `vim-vinegar`)
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" Sort case-insensitive
let g:netrw_sort_options = "i"
" Faster `netrw` but clibpoard might get clobbered
" This doesn't seem to make a difference
" let g:netrw_clipboard = 0
" Don't automatically enter directories when clicking them (instead just move
" the cursor)
let g:netrw_mousemaps = 0

set cursorline
" Highlight just the line number
" set cursorlineopt=number

" Allow moving past the first character on the line, this makes editing prose
" easier
" <,> are arrow keys in normal and visual modes
" [,] are arrow keys in insert mode
set whichwrap+=h,l,<,>,[,]

set completefunc=commands#CompleteRegisters
