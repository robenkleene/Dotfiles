#!/usr/bin/env bash

set -euo pipefail

if [[ -f ~/.nvm/nvm.sh ]]; then
  source ~/.nvm/nvm.sh
else
  echo "Error: nvm not found" >&2
  exit 1
fi

nvm use v13.12.0 || nvm install v13.12.0

cd "$(dirname "$0")" || exit 1
./modules/install.sh "$@"
