let b:terminalorneovim = !has('gui_running') || has('nvim')

" Fix for italics in tmux
set t_ZH=[3m
set t_ZR=[23m

if $TERM_PROGRAM != "Apple_Terminal"
  set termguicolors
endif

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
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'tpope/vim-eunuch', { 'on': [ 'Rename', 'Remove' ] }
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'guns/xterm-color-table.vim', { 'on': 'XtermColorTable' }
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'thinca/vim-visualstar'
" Theme
" Plug 'catppuccin/vim', { 'as': 'catppuccin' }
" Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
" Plug 'whatyouhide/vim-gotham'
" Plug 'haishanh/night-owl.vim', { 'as': 'night-owl' }
Plug 'cocopon/iceberg.vim', { 'as': 'iceberg' }
" Languages
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'neoclide/jsonc.vim', { 'for': 'json'}
Plug 'dag/vim-fish', { 'for': 'fish' }
call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Theme
set background=dark
" Set after plug sync (doesn't help when installing themes)
" let g:embark_terminal_italics = 1
" colorscheme embark
" colorscheme gotham
" colorscheme catppuccin_mocha
" colorscheme night-owl
colorscheme iceberg

" Needs to happen before bindings are set
let mapleader="\<Space>"

command! Ei :cd ~/Developer/Dotfiles/vim | :edit ../vimrc
