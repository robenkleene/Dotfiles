#!/usr/bin/env bash

if tmux info &> /dev/null; then 
  echo "tmux is running, exit tmux first"
  exit 1
fi

filename="tmux_session"
if [[ -n "$1" ]]; then
  filename="$1"
fi

tmux start-server

current_session=""
count=0
while IFS=$'\t' read session_name window_name dir; do
  if [[ "$current_session" = "$session_name" ]]; then
    count=$((count + 1))
  else
    current_session="$session_name"
    count=0
  fi
  current_session="$session_name"
  if [[ -d "$dir" ]]; then
    if tmux has-session -t "$session_name" 2>/dev/null; then
      tmux new-window -d -t="$session_name:$count" -n "$window_name" -c "$dir"
    else
      cd "$dir"
      tmux new-session -d -s "$session_name" -n "$window_name"
    fi
  else
    echo "$dir doesn't exist"
  fi
done < "$filename"

tmux attach
