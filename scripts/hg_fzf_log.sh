#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

hg log --template '{node|short} {author|user}: {desc|strip|firstline}\n' --limit 100 "$1" | \
  fzf --no-sort --ansi --tiebreak=index \
  --preview "echo {} | ~/.bin/nobin/_hg_fzf_rev_preview.sh \"$1\"" \
  --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' \
  --height=100% \
  --preview-window '<30(bottom,30%)' | grep --only-matching "[a-f0-9]\{7\}"
