#!/usr/bin/env bash

while IFS= read -r -d '' i ; do
  cd "$i"
  if [ -d .git ]; then
    git status
  else
    echo "No .git found"
  fi
  echo
done < <(tmux_paths -u -0)
