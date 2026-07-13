#!/usr/bin/env bash

set -eo pipefail

repos=~/Developer/Dotfiles/

if [[ -f "$HOME/.personal" ]]; then
  repos+=:~/Developer/Settings/
  repos+=:~/Developer/Scratch/
  repos+=:~/Developer/Archive/
fi

IFS=':' read -ra repos <<<"$repos"

source ~/.bin/nobin/_rk-giterator.sh

for repo in "${repos[@]}"; do
  giterate "$repo"
done
