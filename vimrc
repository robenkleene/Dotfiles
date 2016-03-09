" Startup {{{1

if &shell =~# 'fish$'
  set shell=bash
endif


" Plugins {{{1

" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
" Tim Pope {{{2
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vinegar'
" Colors {{{2
Plugin 'guns/xterm-color-table.vim'
Plugin 'ap/vim-css-color'
" Editing {{{2
Plugin 'justinmk/vim-sneak'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/syntastic'
if has('lua')
  Plugin 'Shougo/neocomplete.vim'
end
" Git {{{2
Plugin 'airblade/vim-gitgutter'
" Search {{{2
if !has('gui_running')
  Plugin 'junegunn/fzf'
  Plugin 'junegunn/fzf.vim'
end
Plugin 'rking/ag.vim'
" Languages {{{2
Plugin 'dag/vim-fish'
Plugin 'keith/swift.vim'
Plugin 'tpope/vim-markdown'
Plugin 'vim-ruby/vim-ruby'
call vundle#end()
filetype plugin indent on

" Source {{{1
source ~/.vim/robenkleene/settings.vim
source ~/.vim/robenkleene/ui.vim
if !has('gui_running')
  source ~/.vim/robenkleene/colors.vim
endif
source ~/.vim/robenkleene/movement.vim
source ~/.vim/robenkleene/commands.vim
source ~/.vim/robenkleene/bindings.vim

" Source Plugins {{{1
source ~/.vim/robenkleene/plugins/sneak.vim
source ~/.vim/robenkleene/plugins/surround.vim
if has('lua')
  source ~/.vim/robenkleene/plugins/neocomplete.vim
end
source ~/.vim/robenkleene/plugins/fugitive.vim
