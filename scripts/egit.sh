#!/usr/bin/env bash

set -eo pipefail

repos=~/Developer/Dotfiles/
if [[ "$(uname)" == "Darwin" ]]; then
  repos+=:~/Developer/AppleScripts/
fi

if [[ -f "$HOME/.personal" ]]; then
  repos+=:~/Developer/Snippets/:~/Developer/Settings/
  repos+=:~/Developer/Scratch/
  repos+=:~/Developer/Archive/
fi

IFS=':' read -ra repos <<<"$repos"

source ~/.bin/nobin/_giterator.sh

for repo in "${repos[@]}"; do
  giterate "$repo"
done
