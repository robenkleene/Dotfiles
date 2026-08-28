#!/usr/bin/env bash

set -euo pipefail

session_file="$HOME/.rk-tmux-session"

if tmux info &> /dev/null; then
  echo "tmux is running, exit tmux first" >&2
  exit 1
fi

if [[ "$(uname)" = "Linux" && -z "${SSH_AGENT_PID:-}" ]]; then
  eval "$(ssh-agent -s)"
  ssh-add
fi

if [[ ! -f "$session_file" ]]; then
  exec tmux new-session
fi

# Detached sessions default to 80x24, which clamps the restored layouts, so
# create them at the size of the current terminal instead
size="$(stty size 2> /dev/null || true)"
if [[ -z "$size" ]]; then
  size="24 80"
fi
rows="${size% *}"
columns="${size#* }"

declare -A created_sessions=()
declare -A created_windows=()
first_session=""

while IFS=$'\t' read -r _ session window_index window_name dir; do
  if [[ ! -d "$dir" ]]; then
    dir="$HOME"
  fi
  if [[ -z "${created_sessions[$session]:-}" ]]; then
    tmux new-session -d -s "$session" -n "$window_name" -c "$dir" \
      -x "$columns" -y "$rows"
    created_index="$(tmux show-options -gv base-index)"
    if [[ "$created_index" != "$window_index" ]]; then
      tmux move-window -s "$session:$created_index" -t "$session:$window_index"
    fi
    created_sessions[$session]=1
    created_windows[$session:$window_index]=1
    if [[ -z "$first_session" ]]; then
      first_session="$session"
    fi
  elif [[ -z "${created_windows[$session:$window_index]:-}" ]]; then
    tmux new-window -d -t "$session:$window_index" -n "$window_name" -c "$dir"
    created_windows[$session:$window_index]=1
  else
    # A window can run out of room for more panes, and losing one pane beats
    # aborting the restore of everything after it
    if tmux split-window -t "$session:$window_index" -c "$dir"; then
      # Shrink the new pane so the remaining panes still have room to split
      tmux resize-pane -t "$session:$window_index" -U 999
    else
      echo "Skipped a pane in $session:$window_index" >&2
    fi
  fi
done < <(awk -F'\t' '$1 == "pane"' "$session_file")

if [[ -z "$first_session" ]]; then
  exec tmux new-session
fi

while IFS=$'\t' read -r _ session window_index auto_rename layout; do
  tmux select-layout -t "$session:$window_index" "$layout" &> /dev/null || true
  # Naming a window at creation turns `automatic-rename` off, so turn it back
  # on for the windows that were tracking their running command
  if [[ "$auto_rename" = "1" ]]; then
    tmux setw -t "$session:$window_index" automatic-rename on
  fi
done < <(awk -F'\t' '$1 == "window"' "$session_file")

exec tmux attach-session -t "=$first_session"
