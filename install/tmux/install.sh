#!/usr/bin/env bash

set -euo pipefail

if [[ ! -e "$HOME/.tmux/plugins/tpm" ]] && command -v tmux; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/bin/install_plugins
fi
