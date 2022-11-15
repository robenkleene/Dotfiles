#!/usr/bin/env bash

set -eo pipefail

cd ~/Documentation/ && "$HOME/.bin/sgit" "$@"

if [[ ! -f "$HOME/.personal" ]]; then
  exit 0
fi

cd ~/Text/ && "$HOME/.bin/sgit" "$@"

source ~/.bin/nobin/_giterator.sh
giterate "$HOME/Developer/Scratch/"
