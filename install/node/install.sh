#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

if [[ -f ~/.nvm/nvm.sh ]]; then
  source ~/.nvm/nvm.sh
elif [[ ! -e ~/.nvm ]]; then
  git clone https://github.com/nvm-sh/nvm.git ~/.nvm
  if [[ -f ~/.nvm/nvm.sh ]]; then
    source ~/.nvm/nvm.sh
  else
    echo "Error: Failed to install nvm" >&2
    exit 1
  fi
else
  echo "Error: Failed to load nvm" >&2
  exit 1
fi

nvm use v17.0.1 || nvm install v17.0.1

./modules/install.sh -f "$@"
