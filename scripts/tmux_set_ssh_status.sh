#!/usr/bin/env bash

set -euo pipefail

if [ -n "$SSH_CONNECTION" ]; then
  tmux set -g status-style bg=yellow,fg=black
  tmux set -g status-right '#{?client_prefix,-- PREFIX --,} #H'
fi
