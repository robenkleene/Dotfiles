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
set ignorecase
" Use `\C` to make case-sensitive
" Or just use `\c` to make search case insensitive
set smartcase

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
" New strategy is to not use system clipboard with `safecopy` and instead just
" use Vim's system clipboard support, which will automatically integrate with
" the numbered registers so that pasting from the system clipboard  over a
" visual selection doesn't lose the system clipboard, which it does with the
" `safecopy` based system
" Actually setting clipboard this way doesn't use number registers either
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
" Don't let search open folds (useful for determining if a term appears in
" un-folded text)
" Make folds really sticky
" Not sure why removing these doesn't work
" set foldopen-=search,hor,block,percent,quickfix,tag
" But just setting undo is the same thing
set foldopen=undo
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
" Put netrw directories into the jumplist
let g:netrw_keepj = ""
" The `g:netrw_gx` variable determines how `netrw` identifies URLs, by default
" this is set to `<cfile>`, which uses `isfname` variable to determine what to
" use as the URL
" Adding [, ] to `isfname` makes URLs that have brackets work with `gx`
set isfname+=[,]
" Remove `.h` from suffixes, this prevents header files from being sorted at 
" the bottom in `netrw`
set suffixes-=.h

" With my current colorscheme, `iceberg`, this breaks comparing two buffers
" with `:windo diffthis`
" set cursorline
" Highlight just the line number
" set cursorlineopt=number

set completefunc=commands#CompleteRegisters
