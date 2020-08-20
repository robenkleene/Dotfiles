#!/usr/bin/env bash

# System Repos
EGITREPOS=~/Developer/Dotfiles/
if [[ "$(uname)" == "Darwin" ]]; then
  EGITREPOS+=:~/Library/Services/:~/Library/Application\ Support/TextMate/Bundles/Roben\ Kleene.tmbundle/:~/Developer/AppleScripts/:~/Library/Developer/Xcode/UserData/:~/Music/Audio\ Music\ Apps/:~/Library/Application\ Support/Code/User
elif [[ "$(uname)" = "Linux" ]]; then
  EGITREPOS+=:~/.config/Code/User
fi

# General Text Repos
EGITREPOS+=:~/Developer/Snippets/:~/Developer/Settings/
# Last Repos
EGITREPOS+=:~/Developer/Backup/:~/Developer/Archive/:~/Developer/Scratch/


IFS=':' read -ra repos <<< "$EGITREPOS"

source ~/.bin/nobin/_giterator.sh

for repo in "${repos[@]}"; do
  giterate "$repo"
done
