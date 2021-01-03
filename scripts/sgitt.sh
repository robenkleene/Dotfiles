#!/usr/bin/env bash

set -euo pipefail

cd ~/Documentation/ && "$HOME/.bin/sgit" "$@"
cd ~/Text/ && "$HOME/.bin/sgit" "$@"

source ~/.bin/nobin/_giterator.sh
giterate "$HOME/Developer/Scratch/"
