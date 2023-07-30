#!/bin/bash

if tmux info &> /dev/null; then
  echo "tmux is running, exit tmux first"
  exit 1
fi

exec tmux new-session 'tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh'
