#!/usr/bin/env bash

set -euo pipefail

if [ -n "$SSH_CONNECTION" ]; then
  # Green is default `status-style`
  # Yellow is default `message-style`
  # Invert those for `SSH`
  tmux set -g status-style bg=yellow,fg=black
  tmux set -g message-style bg=green,fg=black

  # The host (`#H`) is usually visible from the shell prompt (or front TUI
  # program) so this usually duplicates visible information
  # tmux set -g status-right '#{?client_prefix,-- PREFIX --,} #H'
fi
