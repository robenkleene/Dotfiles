#!/usr/bin/env bash

set -eo pipefail

# System Repos
repos=~/Developer/Dotfiles/
if [[ "$(uname)" == "Darwin" ]]; then
  repos+=:~/Library/Services/:~/Library/Application\ Support/TextMate/Bundles/Roben\ Kleene.tmbundle/:~/Developer/AppleScripts/:~/Library/Developer/Xcode/UserData/:~/Library/Application\ Support/Code/User:~/Library/Application\ Support/Code\ -\ Insiders/User
  if [[ -z "$PUBLIC_EGIT" ]]; then
    repos+=:~/Music/Audio\ Music\ Apps/
  fi
elif [[ "$(uname)" = "Linux" ]]; then
  repos+=:~/.config/Code/User
  repos+=:~/.config/Code\ -\ Insiders/User
fi

if [[ -z "$PUBLIC_EGIT" ]]; then
  # General Text Repos
  repos+=:~/Developer/Snippets/:~/Developer/Settings/
  # Last Repos
  repos+=:~/Developer/Backup/:~/Developer/Archive/
fi

IFS=':' read -ra repos <<<"$repos"

source ~/.bin/nobin/_giterator.sh

for repo in "${repos[@]}"; do
  giterate "$repo"
done
