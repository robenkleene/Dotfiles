#!/usr/bin/env bash

EGITREPOS=~/Development/Dotfiles/:~/Development/Snippets/:~/Development/Archive/:~/Development/Settings/:~/Documentation/design-references/:~/Documentation/development-references/:~/Documentation/music-production-references/:~/Documentation/software-references/:~/Development/Scratch/:~/Documentation/notes/

if [ "$(uname)" == "Darwin" ]; then
  EGITREPOS=$EGITREPOS:~/Library/Services/:~/Library/Application\ Support/TextMate/Bundles/Roben\ Kleene.tmbundle/:~/Library/Scripts/:~/Library/Script\ Libraries/
fi

IFS=':' read -ra repos <<< "$EGITREPOS"

command_name="egit"

source ~/.bin/nobin/_giterator.sh

for repo in "${repos[@]}"; do
  giterate "$repo"
done
