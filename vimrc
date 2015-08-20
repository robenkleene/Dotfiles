" vim:foldmethod=marker

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
Plugin 'airblade/vim-gitgutter'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/syntastic'
Plugin 'thinca/vim-visualstar'
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
Plugin 'kien/ctrlp.vim'
" Colors
Plugin 'guns/xterm-color-table.vim'
if has('lua')
  Plugin 'Shougo/neocomplete.vim'
end
" Languages
Plugin 'dag/vim-fish'
Plugin 'keith/swift.vim'
Plugin 'tpope/vim-markdown'
Plugin 'vim-ruby/vim-ruby'
call vundle#end()
filetype plugin indent on

" Source {{{1
source ~/.vim/robenkleene/settings.vim
source ~/.vim/robenkleene/ui.vim
source ~/.vim/robenkleene/movement.vim
source ~/.vim/robenkleene/commands.vim
source ~/.vim/robenkleene/bindings.vim

" Source Plugins {{{1
source ~/.vim/robenkleene/plugins/surround.vim
if has('lua')
  source ~/.vim/robenkleene/plugins/neocomplete.vim
end
source ~/.vim/robenkleene/plugins/ctrlp.vim
source ~/.vim/robenkleene/plugins/ag.vim
