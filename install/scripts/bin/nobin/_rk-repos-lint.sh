#!/usr/bin/env bash

set -eo pipefail


if [[ -f "$HOME/.personal" ]]; then
  cd "$HOME/Developer/Settings/Repos/Directories/Text" &&
    ./compare.sh
  if [[ "$(uname)" = "Darwin" ]]; then
    cd "$HOME/Developer/Settings/Repos/Directories/Projects" &&
      ./compare.sh mac.txt
  elif [[ "$(uname)" = "Linux" ]]; then
    cd "$HOME/Developer/Settings/Repos/Directories/Projects" &&
      ./compare.sh linux.txt
  fi
fi
