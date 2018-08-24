#!/usr/bin/env bash

if ! tmux info &> /dev/null; then 
  echo "tmux is not running"
  exit 1
fi

filename="tmux_session"
if [[ -n "$1" ]]; then
  filename=$1
fi

d=$'\t'
tmux list-windows -a -F "#S${d}#W${d}#{pane_current_path}" > "$filename"
