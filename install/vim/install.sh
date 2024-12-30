#!/usr/bin/env bash

set -euo pipefail
mkdir -p "$HOME/Developer/Dotfiles/config/nvim/after/ftplugin"
mkdir -p "$HOME/Developer/Dotfiles/config/nvim/after/autoload"
mkdir -p "$HOME/Developer/Dotfiles/config/nvim/after/syntax"
mkdir -p "$HOME/Developer/Dotfiles/config/nvim/ftplugin"
mkdir -p "$HOME/Developer/Dotfiles/config/nvim/plugin"
mkdir -p "$HOME/Developer/Dotfiles/config/nvim/autoload"
~/.bin/sync_symlinks -s "$HOME/Developer/Dotfiles/vim/after/ftplugin" -d "$HOME/Developer/Dotfiles/config/nvim/after/ftplugin" -f
~/.bin/sync_symlinks -s "$HOME/Developer/Dotfiles/vim/after/syntax" -d "$HOME/Developer/Dotfiles/config/nvim/after/syntax" -f
~/.bin/sync_symlinks -s "$HOME/Developer/Dotfiles/vim/after/autoload" -d "$HOME/Developer/Dotfiles/config/nvim/after/autoload" -f
~/.bin/sync_symlinks -s "$HOME/Developer/Dotfiles/vim/ftplugin" -d "$HOME/Developer/Dotfiles/config/nvim/ftplugin" -f
~/.bin/sync_symlinks -s "$HOME/Developer/Dotfiles/vim/plugin" -d "$HOME/Developer/Dotfiles/config/nvim/plugin" -f
# Use `filetype.lua` instead
# if [[ -e "$HOME/Developer/Dotfiles/vim/filetype.vim" ]]; then
#   ln -s "$HOME/Developer/Dotfiles/vim/filetype.vim" "$HOME/Developer/Dotfiles/config/nvim/filetype.vim"
# fi

