#!/usr/bin/env bash

set -eo pipefail

repos=~/Developer/Dotfiles/
repos+=:~/Developer/Snippets/
if [[ "$(uname)" == "Darwin" ]]; then
  repos+=:~/Developer/AppleScripts/
fi

if [[ -f "$HOME/.personal" ]]; then
  repos+=:~/Developer/Settings/
  repos+=:~/Developer/Scratch/
  repos+=:~/Developer/Archive/
else
  repos+=:~/Documentation/design-references/
  repos+=:~/Documentation/software-references/
  repos+=:~/Documentation/audio-references/
  repos+=:~/Documentation/development-references/
  repos+=:~/Documentation/web-references/
fi

IFS=':' read -ra repos <<<"$repos"

source ~/.bin/nobin/_giterator.sh

for repo in "${repos[@]}"; do
  giterate "$repo"
done
