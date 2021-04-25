#!/usr/bin/env bash

set -euo pipefail

cd ~/Documentation/ && "$HOME/.bin/sgit" "$@"

if [[ -n "$PUBLIC_EGIT" ]]; then
  exit 0
fi

cd ~/Text/ && "$HOME/.bin/sgit" "$@"

source ~/.bin/nobin/_giterator.sh
giterate "$HOME/Developer/Scratch/"
