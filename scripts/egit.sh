#!/usr/bin/env bash

# System Repos
EGITREPOS=~/Development/Dotfiles/
if [[ "$(uname)" == "Darwin" ]]; then
  EGITREPOS+=:~/Library/Services/:~/Library/Application\ Support/TextMate/Bundles/Roben\ Kleene.tmbundle/:~/Library/Scripts/:~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/:~/Library/Developer/Xcode/UserData/
fi

# General Text Repos
EGITREPOS+=:~/Development/Snippets/:~/Development/Settings/
# Last Repos
EGITREPOS+=:~/Development/Archive/:~/Development/Scratch/


IFS=':' read -ra repos <<< "$EGITREPOS"

command_name="egit"

source ~/.bin/nobin/_giterator.sh

for repo in "${repos[@]}"; do
  giterate "$repo"
done
