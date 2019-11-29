#!/usr/bin/env bash

set -e

~/.bin/egit -l
cd "$HOME/Development/Dotfiles/scripts" && ./install.sh

cd "$HOME/Development/Settings/Source Control/Directories/Text" && \
  ./compare.sh
if [[ "$(uname)" = "Darwin" ]]; then
  cd "$HOME/Development/Settings/Source Control/Directories/Projects" && \
    ./compare.sh mac.txt
elif [[ "$(uname)" = "Linux" ]]; then
  cd "$HOME/Development/Settings/Source Control/Directories/Projects" && \
    ./compare.sh linux.txt
fi

~/.bin/sgitt -l
~/.bin/sgitp -l
