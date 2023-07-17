#!/usr/bin/env bash

set -euo pipefail

~/.bin/sync_symlinks "$HOME/Developer/Dotfiles/vim/after/ftplugin" "$HOME/Developer/Dotfiles/config/nvim/after/ftplugin"
~/.bin/sync_symlinks "$HOME/Developer/Dotfiles/vim/after/plugin" "$HOME/Developer/Dotfiles/config/nvim/after/plugin"
~/.bin/sync_symlinks "$HOME/Developer/Dotfiles/vim/autoload" "$HOME/Developer/Dotfiles/config/nvim/autoload"
~/.bin/sync_symlinks "$HOME/Developer/Dotfiles/vim/ftplugin" "$HOME/Developer/Dotfiles/config/nvim/ftplugin"
~/.bin/sync_symlinks "$HOME/Developer/Dotfiles/vim/plugin" "$HOME/Developer/Dotfiles/config/nvim/plugin"
