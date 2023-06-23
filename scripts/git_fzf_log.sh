#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

separator="."
if [[ "$#" -eq 1 ]]; then
  separator=" -- "
fi

git log --graph --color=always --format="%C(auto)%h %s%d" ${separator}"${1}" | \
  fzf --no-sort --ansi --tiebreak=index \
  --preview "echo {} | ~/.bin/nobin/_git_fzf_commit_preview.sh \"$1\"" \
  --bind 'ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' \
  --height=100% \
  --preview-window '<30(bottom,30%)' | grep --only-matching "[a-f0-9]\{7\}"
