#!/bin/bash

# unset common shell configuration variables we might want different
unset VISUAL
unset EDITOR
unset PAGER
unset LESS

unset VIM_COMMAND

if tmux info &> /dev/null; then
  echo "tmux is running, exit tmux first"
  exit 1
fi

exec tmux new-session 'tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh'
