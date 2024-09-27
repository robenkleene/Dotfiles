" Fix for italics in tmux
set t_ZH=[3m
set t_ZR=[23m

" Just keeping `termguicolors` off for now so vim always works with Apple
" Terminal (e.g., even over `ssh`)
" if $TERM_PROGRAM != "Apple_Terminal"
"   set termguicolors
" endif

" Bootstrap vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
" Good to be accustomed to not having this, because it makes it easier when
" using implementations of Vim mode that doesn't support this (e.g., in Visual
" Studio Code)
" Plug 'machakann/vim-highlightedyank'
" `editorconfig` is conflicting with `foldmethod=indent`
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'hrsh7th/vim-vsnip'
" More reliable open browser
Plug 'tyru/open-browser.vim'
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-open)
vmap gx <Plug>(openbrowser-open)
" Theme
" Plug 'nordtheme/vim'
" Plug 'catppuccin/vim', { 'as': 'catppuccin' }
" Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
" Plug 'whatyouhide/vim-gotham'
" Plug 'haishanh/night-owl.vim', { 'as': 'night-owl' }
" Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
" Plug 'EdenEast/nightfox.nvim'
" if v:version < 900
Plug 'cocopon/iceberg.vim', { 'as': 'iceberg' }
" endif
" Languages
Plug 'bfrg/vim-cpp-modern', { 'for': [ 'c', 'cpp' ] }
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'neoclide/jsonc.vim', { 'for': 'json' }
call plug#end()

" Install missing plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Set colorscheme only after all vimscript is loaded so our updated colors get
" applied
" `++nested` is required so the override colors autocmd is called
" Theme
" Set after plug sync (doesn't help when installing themes)
" let g:embark_terminal_italics = 1
" colorscheme nord
" colorscheme embark
" colorscheme gotham
" colorscheme night-owl
" colorscheme nightfly
" colorscheme nightfox
" colorscheme duskfox
" colorscheme catppuccin_mocha
" colorscheme iceberg
" colorscheme sorbet
" Don't try to match light dark themes because it's too difficult to make
" consistent over ssh
" Always use dark over SSH because auto-detection of colors doesn't work over
" SSH
if exists('$SSH_CONNECTION') || exists('$TMUX')
  set background=dark
endif
if &background == "dark"
  " colorscheme habamax
  " colorscheme sorbet
  colorscheme wildcharm
else
  colorscheme shine
endif
" colorscheme iceberg

"VimEnter * ++nested colorscheme iceberg
" if v:version < 900
"   autocmd VimEnter * ++nested colorscheme iceberg
" else
"   autocmd VimEnter * ++nested colorscheme sorbet
" endif

" Needs to happen before bindings are set
let mapleader="\<Space>"

" Indent
" When opening lines, make it the same indent level as the current line
" Neovim defaults to `autoindent`
set autoindent

" Highlight search results
" This is important even when doing a substitution, because it makes clear
" when you might have false positives
" Neovim defaults to `hlsearch`
set hlsearch

" Fix a problem in Vim where a bunch of escaped junk is shown in the window
augroup focus_redraw
  autocmd!
  autocmd FocusGained * redraw!
augroup END

" Fix option key in Vim
let c='a'
while c <= 'z'
  exec "set <M-".tolower(c).">=\e".c
  exec "nnoremap \e".c." <M-".tolower(c).">"
  let c = nr2char(1+char2nr(c))
endw
