#!/usr/bin/env bash

while IFS= read -r -d '' i ; do
  cd "$i"
  if [ -d .git ]; then
    git status
  fi
  echo
done < <(tmux-paths -0)
