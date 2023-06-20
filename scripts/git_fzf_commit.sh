#!/usr/bin/env bash

set -euo pipefail

git log --graph --color=always --format="%C(auto)%h %s%d " | \
  fzf --no-sort --ansi --tiebreak=index \
  --preview 'echo {} | ~/.bin/nobin/_git_fzf_commit_preview.sh' \
  --preview-window=top:15 | grep --only-matching "[a-f0-9]\{7\}"
