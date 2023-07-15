#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

hash=$(cat | grep --only-matching "[a-f0-9]\{7\}" | sed 's/\s.*$//' | head -1)

if [[ "$#" -eq 1 ]]; then
  hg log --color=always --patch --rev "$hash" "$1"
else
  hg show --color=always "$hash"
fi

