#!/usr/bin/env bash

set -euo pipefail

if [ -n "$SSH_CONNECTION" ]; then
  tmux set -g status-style bg=yellow,fg=black
  # The host (`#H`) is usually visible from the shell prompt (or front TUI
  # program) so this usually duplicates visible information
  # tmux set -g status-right '#{?client_prefix,-- PREFIX --,} #H'
fi
