" NeoVim Init
" On fresh install, do this:
" ln -s ~/.vim ~/.config/nvim
" and:
" pip3 install neovim

" Startup {{{1

if &shell =~# 'fish$'
  set shell=bash
endif

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
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-rhubarb'
" Colors {{{2
Plug 'guns/xterm-color-table.vim', { 'on': 'XtermColorTable' }
Plug 'ap/vim-css-color', { 'for': 'css' }

" Editing {{{2
Plug 'editorconfig/editorconfig-vim'
" `file-line` breaks process substituion by file, e.g.
" `vimdiff <(echo "test 1") <(echo "test 2")`
" Plug 'bogado/file-line'
Plug 'w0rp/ale'
Plug 'junegunn/rainbow_parentheses.vim', { 'on': 'RainbowParentheses' }
Plug 'janko-m/vim-test', { 'on': ['TestNearest', 'TestFile', 'TestSuite', 
      \ 'TestLast', 'TestVisit'] }
Plug 'Konfekt/FastFold'
Plug 'SirVer/ultisnips'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'Konfekt/vim-alias'
Plug 'junegunn/goyo.vim'
Plug 'AndrewRadev/linediff.vim'
" Git {{{2
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
" Navigation {{{2
let b:terminalorneovim = !has('gui_running') || has('nvim')
" TODO Figure out how to make the conditional work
" Plug 'junegunn/fzf.vim', { 'on': ['Buffers', 'BLines', 'Files', 'History', 'Modified', 'Gfzf', 'Gfzfr' ] }
Plug 'junegunn/fzf.vim', Cond(b:terminalorneovim)
" Also update `fzf` in external directory, it's a good idea to keep the plugin
" and `fzf` version in sync
Plug 'junegunn/fzf', Cond(b:terminalorneovim, { 'dir': '~/.fzf', 'do': './install --no-key-bindings --no-update-rc' })
Plug 'ctrlpvim/ctrlp.vim', Cond(!b:terminalorneovim)
Plug 'roxma/vim-tmux-clipboard', Cond(has('nvim'))
Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle'] }
" Languages {{{2
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
call plug#end()
