#!/usr/bin/env bash

set -euo pipefail

set -x
# System Repos
repos=~/Developer/Dotfiles/
if [[ "$(uname)" == "Darwin" ]]; then
  repos+=:~/Library/Services/:~/Library/Application\ Support/TextMate/Bundles/Roben\ Kleene.tmbundle/:~/Developer/AppleScripts/:~/Library/Developer/Xcode/UserData/:~/Music/Audio\ Music\ Apps/:~/Library/Application\ Support/Code/User:~/Library/Application\ Support/Code\ -\ Insiders/User
elif [[ "$(uname)" = "Linux" ]]; then
  repos+=:~/.config/Code/User
  repos+=:~/.config/Code\ -\ Insiders/User
fi

# General Text Repos
repos+=:~/Developer/Snippets/:~/Developer/Settings/
# Last Repos
repos+=:~/Developer/Backup/:~/Developer/Archive/:~/Developer/Scratch/

IFS=':' read -ra repos <<<"$repos"

source ~/.bin/nobin/_giterator.sh

for repo in "${repos[@]}"; do
  giterate "$repo"
done
