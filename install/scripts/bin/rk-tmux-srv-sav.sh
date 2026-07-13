#!/bin/bash

if ! tmux info &> /dev/null; then
  # tmux isn't running
  exit 0
fi

exec tmux run-shell "$HOME/.tmux/plugins/tmux-resurrect/scripts/save.sh"
