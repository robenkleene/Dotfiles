#!/usr/bin/env bash

set -euo pipefail

session_file="$HOME/.rk-tmux-session"

if ! tmux info &> /dev/null; then
  # tmux isn't running
  exit 0
fi

# Field separator for the session file
d=$'\t'

tmp_file="$(mktemp "$session_file.XXXXXX")"
trap 'rm -f "$tmp_file"' EXIT

# One `pane` line per pane, in the order the panes are restored, and one
# `window` line per window carrying the layout to lay those panes back out
{
  tmux list-panes -a -F "pane$d#{session_name}$d#{window_index}$d#{window_name}$d#{pane_current_path}"
  tmux list-windows -a -F "window$d#{session_name}$d#{window_index}$d#{?automatic-rename,1,0}$d#{window_layout}"
} > "$tmp_file"

mv "$tmp_file" "$session_file"
trap - EXIT
