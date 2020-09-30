#!/usr/bin/env bash

# `^bash$` matches this script running
commands=$(tmux list-panes -a -F "#{pane_current_command}" | grep --extended-regexp --invert-match "^zsh$|^bash$|^fish$")
status=$?
if [[ $status -eq 0 ]]; then
  commands=${commands//$'\n'/ }
  echo "Panes found running commands: $commands" >&2
  exit 1
fi

tmux run-shell "$HOME/.tmux/plugins/tmux-resurrect/scripts/save.sh"
tmux kill-server
