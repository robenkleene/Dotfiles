" Temporary Directories {{{1

" Swap File directory
" Double-slash prevents name collusions
let s:temporary_directory = "/tmp/vim.robenkleene/"
let s:swap_file_directory = s:temporary_directory . "swap"
let s:viewdir_directory = s:temporary_directory . "view"
if !isdirectory(s:swap_file_directory)
  call mkdir(s:swap_file_directory, 'p')
endif
if !isdirectory(s:viewdir_directory)
  call mkdir(s:viewdir_directory, 'p')
endif
let &directory=s:swap_file_directory . "//"
let &viewdir=s:viewdir_directory

" Disable swap files
set noswapfile

" Restore buffer local options
" set sessionoptions+=localoptions
" Match this to `viewoptions`
set sessionoptions-=options
set sessionoptions-=folds


" Basic {{{1

" set spell spelllang=en_us

" Fix arrow keys
if &term =~ '^screen'
  " tmux will send xterm-style keys when xterm-keys is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

" Syntax highlighting
syntax on

" Use system clipboard by default
" This option breaks visual block mode paste, e.g., pasting a column of text
" after another column. The workaround is to paste from the system clipboard
" with `"*p`.
set clipboard^=unnamed,unnamedplus

" Disable mouse
" set mouse=
set mouse=a
" This greatly improves mouse support with `vim` in `tmux`. Specifically it
" allows `vim` windows to be resized inside `tmux` and it stops `vim` from
" scrolling when switching windows with the mouse..
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

" Set Word Boundaries
" For `-` and `_` there are two schools of thought:
" 1. They should not be in `iskeyword` in order to match the `bash` default
" 2. They should be in `iskeyword` because it facilitates searching for 
" symbols with the `*` command.
" set iskeyword-=_
set iskeyword+=-

" Allow hidden buffers
set hidden

" Text
set nowrap

" Automatically change the working directory
" This interferes with `ag`
" set autochdir
" Just autoset the directory for netrw
" let g:netrw_keepdir = 0

" Show commands as they're typed
set showcmd

" Line breaks only happen on words
set linebreak

" Default Fold Method
set foldmethod=syntax

" Show folds in gutter
set foldcolumn=1

" Don't Start Folded
set nofoldenable

" Ignore case in search results
set ignorecase

" Override `ignorecase`
" `smartcase` with `ignorecase` is preferable for two reasons:
" 1. It facilitates incremental search for jumping to a specific token.
" 2. Usually a search starts broad and gets more specific, so it makes sense
" to go from `ignorecase` to `case-sensitive`.
" This has the downside of making a search with `*`, for a token often times
" be too board (since `*` uses `ignorecase` but not `smartcase`). But that's
" the less common case.
" The fastests way to go from a `*` search to the same search with `smartcase`
" is to hit `/`, then up, then enter.
set smartcase

" Live Substitution Preview
if has('nvim')
  " set inccommand=nosplit
  set inccommand=split
endif

if has('nvim')
  " This improves startup time drastically by removing the need to detect
  " clipboard settings.
  " This can be confirmed by running `nvim --startuptime profile.log`
  " Linux doesn't have the same startup cost, so the automatic detection is
  " fine there, it makes `tmux` clipboard work automatically.
  if has('macunix')
    let g:clipboard = {
      \ 'name': 'pbcopy',
      \ 'copy': {
      \    '+': 'pbcopy',
      \    '*': 'pbcopy',
      \  },
      \ 'paste': {
      \    '+': 'pbpaste',
      \    '*': 'pbpaste',
      \ },
      \ 'cache_enabled': 0,
      \ }
  endif
endif


" open previews vertically
" let g:netrw_preview = 1

" Open splits in bottom right
set splitbelow
set splitright

" Don't add an extra space when joining two paragraphs
set nojoinspaces

" Show whitespace
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set list

" Hide dot files in file list (`gh` to toggle in `vim-vinegar`)
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" Remove `.h` from suffixes, this prevents header files from being sorted at 
" the bottom in `netrw`
set suffixes-=.h

" Allow autocomplete dictionary
set dictionary+=/usr/share/dict/words

" Don't let `smartcase` affect auto-complete
" This option was causing auto-complete option with the wrong case to appear
" set infercase

" Don't auto-select the first full match
" This makes it easier to get to one option of many
" Trying this off because not auto-selecting the first match is annoying and
" often always requires an extra keystroke to select.
" set completeopt+=longest

" Use `rg` if available
" if executable("rg")
  " set grepprg=rg\ --smart-case\ --vimgrep\ --no-heading
"   " set grepformat=%f:%l:%c:%m,%f:%l:%m
" endif

" Make `find <filename>` find files recursively
set path+=**
" Autocmd {{{1

" Languages {{{1

" Doesn't work in ftplugin
let g:xml_syntax_folding=1
