#!/usr/bin/env bash

set -eo pipefail


if [[ -z "$PUBLIC_EGIT" ]]; then
  cd "$HOME/Developer/Dotfiles/install/repos/documentation" &&
    ./compare.sh
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
fi
