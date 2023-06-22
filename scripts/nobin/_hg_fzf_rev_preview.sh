#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

hash=$(cat | head -1 | grep --only-matching "[a-f0-9]\{7\}")
# No idea why this only works as a separate step
hash=$(echo "$hash" | cut -d ' ' -f1)
if [[ "$#" -eq 1 ]]; then
  hg log --color=always --patch --rev "$hash" "$1"
else
  hg show --color=always "$hash"
fi

