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

" Indent wrapped lines
set breakindent

" Sensible turns it on, and it's on by default in Neovim
" Incremental search
set noincsearch

" Smartcase
" Without this, a lowercase search will not match words with uppercase
" letters, even if `smartcase` is on
"set ignorecase
" Use `\C` to make case-sensitive
" Or just use `\c` to make search case insensitive
"set smartcase

" Don't display saved search highlights on startup
nohlsearch

" Add hyphen to word characters, this shouldn't be set as a default and
" instead be set per filetype
" set iskeyword+=-
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
" the numbered registers so that pasting from the system clipboard over a
" visual selection doesn't lose the system clipboard, which it does with the
" `safecopy` based system
" Actually setting clipboard this way doesn't use number registers either
" set clipboard^=unnamed,unnamedplus
" Autocomplete max height
" Setting this two high is annoying with autocomplete
set pumheight=10
" Disable swap files, this allows multiple instances to edit the same file
set noswapfile
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
" Prefer spaces to tabs
set expandtab
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
" Complete to longest match and show a menu, matching the typical `zsh` setup.
" Note this doesn't seem to always work, e.g., `:tag <term><tab>` doesn't seem
" to complete to the longest common string. But you can test the setting is
" correct by going to a directory with matching filenames and trying `:e
" <term><tab>`
set wildmode=longest:full,full
" This is causing an issue where the text to complete gets deleted
" It also sometimes just looks ugly like the text for the full match shows for
" an instant and then gets deleted
" Turn this on, it makes exploring an API with completion a lot easier,
" without it trigger completion will select an item and enter it in the
" buffer, so the completion options can't be narrowed again after starting a
" completion
 set completeopt+=longest
 " This shows a popup split which has somewhat useful information but is very
 " disconcerting because it moves the text of the current split as well
 set completeopt-=preview
" Use a vertical wildmenu
" set wildoptions=pum
" Show column vertical line
" `+0` means match `colorcolumn` to `textwidth`
" Don't set a `textwidth` explicitly, it has too many side effects like giving
" a text width in buffers with no filetype set
set colorcolumn=+0
" Line breaks only happen on words
set linebreak
" Launch without wrapped lines
set nowrap
" Don't timeout leader key
"set notimeout
" Don't turn off timeout instead set it a bit longer, this way if part of a
" command is accidently typed, e.g., `"*` to specify a register, and then you
" want to start over, you can just wait to start over. Without this, there
" doesn't seem to be a way to start over without side effects (e.g., `esc`
" will disable a visual mode selection).
"set timeoutlen 3000
" Don't prompt when trying to navigate to another buffer when current buffer
" is modified
" This causes the `%` register to not be set when opening a directory, e.g.,
" `vim .` the `%` register won't be set and `cd %` will fail
" Without this, navigating away from a buffer will "abandon" it, i.e., remove
" it from the buffer list and discard its contents. This means `gF` to go to a
" grep line followed by `<C-o>` to go back will fail
set hidden

" Adding [, ] to `isfname` makes URLs that have brackets work with `gx`
set isfname+=[,]
" Remove `.h` from suffixes, this prevents header files from being sorted at 
" the bottom in `netrw`
set suffixes-=.h

" With my current colorscheme, `iceberg`, this breaks comparing two buffers
" with `:windo diffthis`
" Don't bother with this because it isn't super helpful to find the cursor
" when there's multiple splits with highlighted lines. The easiest way to
" repliably find the cursor quickly is set the terminal emulator to use a
" bright cursor color.
"set cursorline
" Highlight just the line number
"set cursorlineopt=number
