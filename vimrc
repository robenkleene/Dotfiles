" Bootstrap vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
" The built in `:Man` command uses `-complete=shellcmd`
" This needs to be loaded before `vim-sensible` to prevent sensible from
" loading the builtin `:Man` first
Plug 'vim-utils/vim-man'
" This breaks completion before running the command once
" Plug 'vim-utils/vim-man', { 'on': 'Man' }
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" `editorconfig` is conflicting with `foldmethod=indent`
Plug 'editorconfig/editorconfig-vim'
Plug 'robenkleene/partshell.vim'
Plug 'robenkleene/gotogrep.vim'
Plug 'robenkleene/gotodiff.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'prabirshrestha/asyncomplete.vim'
" Languages
Plug 'bfrg/vim-c-cpp-modern', { 'for': [ 'c', 'cpp' ] }
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

colorscheme lunaperche

" Needs to happen before bindings are set
let mapleader="\<Space>"

if filereadable(expand('~/.vimrc_local.vim'))
  source $HOME/.vimrc_local.vim
endif
