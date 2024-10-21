#!/bin/bash

if tmux info &> /dev/null; then
  echo "tmux is running, exit tmux first"
  exit 1
fi

if [[ "$(uname)" = "Linux" && -z "$SSH_AGENT_PID" ]]; then
  eval "$(ssh-agent -s)"
  ssh-add
fi

exec tmux new-session 'tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh'
