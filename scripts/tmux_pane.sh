#!/usr/bin/env bash

set -e

if [[ $# -eq 0 ]]; then
  while read line; do
    paths=("${paths[@]}" $line)
  done
else
  paths=$@
fi

for path in "${paths[@]}"; do
  full_path=$(echo $(cd "$path"; pwd))
  tmux split-window -c "$full_path"
  tmux last-pane
  tmux select-layout even-vertical
done

tmux kill-pane
