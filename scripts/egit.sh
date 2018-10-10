#!/usr/bin/env bash

EGITREPOS=~/Development/Dotfiles/:~/Development/Snippets/:~/Development/Archive/:~/Development/Settings/:~/Documentation/design-references/:~/Documentation/development-references/:~/Documentation/music-production-references/:~/Documentation/software-references/:~/Development/Scratch/:~/Documentation/notes/:~/Development/Planning/personal-projects:~/Development/Planning/thepotionlab-development:~/Development/Planning/thepotionlab-projects

if [ "$(uname)" == "Darwin" ]; then
  EGITREPOS=$EGITREPOS:~/Library/Services/:~/Library/Application\ Support/TextMate/Bundles/Roben\ Kleene.tmbundle/:~/Library/Scripts/:~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
fi

IFS=':' read -ra repos <<< "$EGITREPOS"

command_name="egit"

source ~/.bin/nobin/_giterator.sh

for repo in "${repos[@]}"; do
  giterate "$repo"
done
