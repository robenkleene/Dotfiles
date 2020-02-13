#!/usr/bin/env bash

# System Repos
EGITREPOS=~/Development/Dotfiles/
if [[ "$(uname)" == "Darwin" ]]; then
  EGITREPOS+=:~/Library/Services/:~/Library/Application\ Support/TextMate/Bundles/Roben\ Kleene.tmbundle/:~/Development/AppleScripts/:~/Library/Developer/Xcode/UserData/:~/Music/Audio\ Music\ Apps/:~/Library/Application\ Support/VSCodium/User
fi

# General Text Repos
EGITREPOS+=:~/Development/Snippets/:~/Development/Settings/
# Last Repos
EGITREPOS+=:~/Development/Backup/:~/Development/Archive/:~/Development/Scratch/


IFS=':' read -ra repos <<< "$EGITREPOS"

source ~/.bin/nobin/_giterator.sh

for repo in "${repos[@]}"; do
  giterate "$repo"
done
