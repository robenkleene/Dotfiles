#!/usr/bin/env bash

set -euo pipefail

git log --graph --color=always --format="%C(auto)%h %s%d " | \
  fzf --no-sort --ansi --tiebreak=index \
  --preview 'git show --color=always (echo {} | grep -o "[a-f0-9]\{7,\}") | head -1' \
  --preview-window=top:15
