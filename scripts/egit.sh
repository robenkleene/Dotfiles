#!/usr/bin/env bash

# System Repos
EGITREPOS=~/Development/Dotfiles/
if [ "$(uname)" == "Darwin" ]; then
  EGITREPOS+=:~/Library/Services/:~/Library/Application\ Support/TextMate/Bundles/Roben\ Kleene.tmbundle/:~/Library/Scripts/:~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/:~/Library/Developer/Xcode/UserData/
fi

# General Text Repos
EGITREPOS+=:~/Development/Snippets/:~/Development/Archive/:~/Development/Scratch/:~/Development/Settings/
# Specific Text Repos
EGITREPOS+=:~/Documentation/notes/:~/Documentation/design-references/:~/Documentation/development-references/:~/Documentation/music-production-references/:~/Documentation/software-references/:~/Documentation/Planning/personal-projects:~/Documentation/Planning/thepotionlab-development:~/Documentation/Planning/thepotionlab-projects

IFS=':' read -ra repos <<< "$EGITREPOS"

command_name="egit"

source ~/.bin/nobin/_giterator.sh

for repo in "${repos[@]}"; do
  giterate "$repo"
done
