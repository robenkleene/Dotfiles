#!/usr/bin/env bash


if [[ -n "${TMUX:-}" ]]; then
  echo "Don't kill the server while attached to it, detach first" >&2
  exit 1
fi

if ! tmux info &> /dev/null; then
  # tmux isn't running
  exit 0
fi

# Panes sitting at a shell prompt are idle, anything else is a command
commands=$(tmux list-panes -a -F "#{pane_current_command}" | grep --extended-regexp --invert-match "^zsh$|^bash$|^fish$|^nu$")
status=$?
if [[ $status -eq 0 ]]; then
  commands=${commands//$'\n'/ }
  echo "Panes found running commands: $commands" >&2
  exit 1
fi

~/.bin/rk-tmux-srv-sav
tmux kill-server
