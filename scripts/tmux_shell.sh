#!/usr/bin/env bash

set -e
current_session=$(tmux display-message -p '#S')
shell_session_name="Shell"
if [[ "$current_session" = "$shell_session_name" ]]; then
  tmux switch-client -l
  exit 0
fi
if ! tmux has-session -t "$shell_session_name" >/dev/null; then
  tmux new-session -s "$shell_session_name" -d
fi
tmux switch-client -t "$shell_session_name"
