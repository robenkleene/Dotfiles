#!/usr/bin/env bash

set -euo pipefail
mkdir -p "$HOME/Developer/Dotfiles/config/nvim/after/ftplugin"
mkdir -p "$HOME/Developer/Dotfiles/config/nvim/after/plugin"
mkdir -p "$HOME/Developer/Dotfiles/config/nvim/ftplugin"
mkdir -p "$HOME/Developer/Dotfiles/config/nvim/plugin"
~/.bin/sync_symlinks -s "$HOME/Developer/Dotfiles/vim/after/ftplugin" -d "$HOME/Developer/Dotfiles/config/nvim/after/ftplugin" -f
~/.bin/sync_symlinks -s "$HOME/Developer/Dotfiles/vim/after/plugin" -d "$HOME/Developer/Dotfiles/config/nvim/after/plugin" -f
~/.bin/sync_symlinks -s "$HOME/Developer/Dotfiles/vim/ftplugin" -d "$HOME/Developer/Dotfiles/config/nvim/ftplugin" -f
~/.bin/sync_symlinks -s "$HOME/Developer/Dotfiles/vim/plugin" -d "$HOME/Developer/Dotfiles/config/nvim/plugin" -f
