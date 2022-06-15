#!/usr/bin/env bash

set -eo pipefail

# System Repos
repos=~/Developer/Dotfiles/
if [[ "$(uname)" == "Darwin" ]]; then
  repos+=:~/Library/Services/:~/Developer/AppleScripts/
fi

if [[ -z "$PUBLIC_EGIT" ]]; then
  # General Text Repos
  repos+=:~/Developer/Snippets/:~/Developer/Settings/
  # Last Repos
  repos+=:~/Developer/Archive/
fi

IFS=':' read -ra repos <<<"$repos"

source ~/.bin/nobin/_giterator.sh

for repo in "${repos[@]}"; do
  giterate "$repo"
done
