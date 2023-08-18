#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

# hg log shows `9` characters, but other presentations of hashes only have `9`
# [^A-Z] Removes things like diff and task #s
hash=$(cat | grep --only-matching "[^A-Z][a-f0-9]\{9\}[a-f0-9]* " | sed 's/\s.*$//' | head -1)

if [[ "$#" -eq 1 ]]; then
  hg log --color=always --patch --rev "$hash" "$1"
else
  hg show --color=always "$hash"
fi
