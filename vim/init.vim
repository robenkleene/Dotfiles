" NeoVim Init
" On fresh install, do this:
" ln -s ~/.vim ~/.config/nvim
" and:
" pip3 install neovim

" Startup {{{1
" if &shell =~# 'zsh$'
"   " Make shell interactive to aliases work.
"   set shell=zsh\ -i
" endif

" Check Status {{{1
if has('nvim') && !has("python3")
  echom "Running nvim without python3"
endif

" Plugins {{{1

" Install Vim-Plug if it is missing
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" Conditional Helper Function
function! Cond(cond, ...) abort
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.vim/plugged')
" Tim Pope {{{2
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
" NeoVim `:CheckHealth` says sensible isn't necessary, but `<C-l>` stops
" clearing search without it
Plug 'tpope/vim-sensible' ", Cond(!has('nvim'))
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-rsi'

" Colors {{{2
Plug 'guns/xterm-color-table.vim', { 'on': 'XtermColorTable' }
" Disabling this for now, this causes a conflict when entering the
" command-line window, to replicate enter `%s//` in the command line and then
" trigger `<C-f>`. At this time if `vim-css-color` is enabled it dumps an error.
" Plug 'ap/vim-css-color', { 'for': 'css' }

" Editing {{{2
Plug 'editorconfig/editorconfig-vim'
" `file-line` breaks process substituion by file, e.g.
" `vimdiff <(echo "test 1") <(echo "test 2")`
" Plug 'bogado/file-line'
Plug 'w0rp/ale'
Plug 'junegunn/rainbow_parentheses.vim', { 'on': 'RainbowParentheses' }
Plug 'janko-m/vim-test', { 'on': ['TestNearest', 'TestFile', 'TestSuite', 
      \ 'TestLast', 'TestVisit'] }
" Disabling this for now, this causes a conflict when entering the
" command-line window, to replicate enter `%s//` in the command line and then
" trigger `<C-f>`. At this time if `FastFold` is enabled it dumps an error.
" Plug 'Konfekt/FastFold'
" NOTE: `ultisnips` slows input in `nvim`
Plug 'SirVer/ultisnips'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'Konfekt/vim-alias'
Plug 'junegunn/goyo.vim'
Plug 'AndrewRadev/linediff.vim'
Plug 'kana/vim-textobj-user'
Plug 'markonm/traces.vim' , Cond(!has('nvim'))
" Git {{{2
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
" Navigation {{{2
let b:terminalorneovim = !has('gui_running') || has('nvim')
" `, { 'on': 'Dirvish' }` doesn't work for some reason
Plug 'justinmk/vim-dirvish'
" Also update `fzf` in external directory, it's a good idea to keep the plugin
" and `fzf` version in sync
" TODO Figure out how to make the conditional work
" Plug 'junegunn/fzf.vim', { 'on': ['Buffers', 'BLines', 'Files', 'History', 'Modified', 'Gfzf', 'Gfzfr' ] }
Plug 'junegunn/fzf.vim', Cond(b:terminalorneovim)
Plug 'junegunn/fzf', Cond(b:terminalorneovim, { 'dir': '~/.fzf', 'do': './install --no-key-bindings --no-update-rc --no-completion' })
Plug 'ctrlpvim/ctrlp.vim', Cond(!b:terminalorneovim)
if !has('macunix')
  " This slows down `dd` significantly
  Plug 'roxma/vim-tmux-clipboard'
endif
Plug 'wsdjeg/vim-fetch'
" Languages {{{2
Plug 'tpope/vim-ragtag', { 'for': ['html', 'xml'] }
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'wsdjeg/FlyGrep.vim'
call plug#end()
