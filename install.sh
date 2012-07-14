#!/bin/sh

# Files
ln -s ~/Dotfiles/profile ~/.profile
ln -s ~/Dotfiles/inputrc ~/.inputrc
ln -s ~/Dotfiles/vimrc ~/.vimrc
ln -s ~/Dotfiles/zshrc ~/.zshrc

# Directories
ln -s ~/Dotfiles/vim ~/.vim
ln -s ~/Dotfiles/oh-my-zsh ~/.oh-my-zsh

git submodule init
