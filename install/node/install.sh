#!/usr/bin/env bash

set -euo pipefail

if [[ -f ~/.nvm/nvm.sh ]]; then
  source ~/.nvm/nvm.sh
else
  echo "Error: nvm not found" >&2
  exit 1
fi

nvm use v17.0.1 || nvm install v17.0.1

cd "$(dirname "$0")" || exit 1
./modules/install.sh -f "$@"
