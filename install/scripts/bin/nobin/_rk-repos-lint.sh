#!/usr/bin/env bash

set -eo pipefail


if [[ -f "$HOME/.robenkleene" ]]; then
  cd "$HOME/Developer/Settings/Repos/Dirs/Text" &&
    ./compare.sh
  if [[ "$(uname)" = "Darwin" ]]; then
    cd "$HOME/Developer/Settings/Repos/Dirs/Projects" &&
      ./compare.sh mac.txt
  elif [[ "$(uname)" = "Linux" ]]; then
    cd "$HOME/Developer/Settings/Repos/Dirs/Projects" &&
      ./compare.sh linux.txt
  fi
fi
