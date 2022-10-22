#!/usr/bin/env bash

set -eo pipefail

repos=~/Developer/Dotfiles/
repos+=:~/.config/Code/User
if [[ "$(uname)" == "Darwin" ]]; then
  repos+=:~/Library/Services/:~/Developer/AppleScripts/
fi

if [[ -z "$PUBLIC_EGIT" ]]; then
  repos+=:~/Developer/Snippets/:~/Developer/Settings/
  repos+=:~/Developer/Archive/
fi

IFS=':' read -ra repos <<<"$repos"

source ~/.bin/nobin/_giterator.sh

for repo in "${repos[@]}"; do
  giterate "$repo"
done
