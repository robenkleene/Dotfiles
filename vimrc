" Startup {{{1

if &shell =~# 'fish$'
  set shell=bash
endif

" Plugins {{{1

" Install Vim-Plug if it is missing
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')
" Tim Pope {{{2
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-scriptease'
" Colors {{{2
Plug 'guns/xterm-color-table.vim', { 'on': 'XtermColorTable' }
Plug 'ap/vim-css-color'
" Editing {{{2
Plug 'editorconfig/editorconfig-vim'
Plug 'bogado/file-line'
Plug 'scrooloose/syntastic'
Plug 'junegunn/rainbow_parentheses.vim', { 'on': 'RainbowParentheses' }
Plug 'janko-m/vim-test', { 'on': ['TestNearest', 'TestFile', 'TestSuite', 
      \ 'TestLast', 'TestVisit'] }
Plug 'Konfekt/FastFold'
if has('lua')
  Plug 'Shougo/neocomplete.vim'
end
" Git {{{2
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" Navigation {{{2
Plug 'ctrlpvim/ctrlp.vim', { 'on': [] }
Plug 'junegunn/fzf', { 'on': [] }
Plug 'junegunn/fzf.vim', { 'on': [] }
if has('gui_running')
  call plug#load('ctrlp.vim')
else
  call plug#load('fzf', 'fzf.vim')
end
" Languages {{{2
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
call plug#end()

" Source {{{1
source ~/.vim/robenkleene/settings.vim
source ~/.vim/robenkleene/ui.vim
if !has('gui_running')
  source ~/.vim/robenkleene/colors.vim
endif
source ~/.vim/robenkleene/commands.vim
source ~/.vim/robenkleene/bindings.vim
source ~/.vim/robenkleene/abbreviations.vim

" Plugins {{{1
source ~/.vim/robenkleene/plugin/commentary.vim
if has('gui_running')
  source ~/.vim/robenkleene/plugin/ctrlp.vim
else
  source ~/.vim/robenkleene/plugin/fzf.vim
end
source ~/.vim/robenkleene/plugin/test.vim
source ~/.vim/robenkleene/plugin/fugitive.vim
source ~/.vim/robenkleene/plugin/neocomplete.vim
source ~/.vim/robenkleene/plugin/surround.vim
source ~/.vim/robenkleene/plugin/syntastic.vim
source ~/.vim/robenkleene/plugin/rainbow_parentheses.vim
source ~/.vim/robenkleene/plugin/vim-gitgutter.vim
