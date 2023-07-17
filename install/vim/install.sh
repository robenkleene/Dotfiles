#!/usr/bin/env bash

set -euo pipefail

~/.bin/sync_symlinks -s "$HOME/Developer/Dotfiles/vim/after/ftplugin" -d "$HOME/Developer/Dotfiles/config/nvim/after/ftplugin"
~/.bin/sync_symlinks -s "$HOME/Developer/Dotfiles/vim/after/plugin" -d "$HOME/Developer/Dotfiles/config/nvim/after/plugin"
~/.bin/sync_symlinks -s "$HOME/Developer/Dotfiles/vim/autoload" -d "$HOME/Developer/Dotfiles/config/nvim/autoload"
~/.bin/sync_symlinks -s "$HOME/Developer/Dotfiles/vim/ftplugin" -d "$HOME/Developer/Dotfiles/config/nvim/ftplugin"
~/.bin/sync_symlinks -s "$HOME/Developer/Dotfiles/vim/plugin" -d "$HOME/Developer/Dotfiles/config/nvim/plugin"
