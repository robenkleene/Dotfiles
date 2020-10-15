#!/usr/bin/env bash

set -e

~/.bin/egit -u
cd "$HOME/Developer/Dotfiles/scripts" && ./install.sh

cd "$HOME/Developer/Settings/Source Control/Directories/Text" &&
  ./compare.sh
if [[ "$(uname)" = "Darwin" ]]; then
  cd "$HOME/Developer/Settings/Source Control/Directories/Projects" &&
    ./compare.sh mac.txt
  cd "$HOME/Developer/Settings/Source Control/Directories/Max/" &&
    ./compare.sh
elif [[ "$(uname)" = "Linux" ]]; then
  cd "$HOME/Developer/Settings/Source Control/Directories/Projects" &&
    ./compare.sh linux.txt
fi

~/.bin/sgitt -u
~/.bin/sgitp -u
if [[ "$(uname)" = "Darwin" ]]; then
  ~/.bin/sgitm -u
fi
