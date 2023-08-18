#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

separator=" ."
if [[ -n "${1-}" ]]; then
  separator=" -- "
fi

git log --graph --color=always --format="%C(auto)%h %s%d"${separator}"${1}" | \
  fzf --no-sort --ansi --reverse --multi \
  --preview "echo {} | ~/.bin/nobin/_f_a_git_commit_preview.sh \"$1\"" \
  --bind="alt-p:become(echo {} | ~/.bin/nobin/_f_a_git_commit_preview.sh \"$1\"),alt-u:become(echo {} | ~/.bin/nobin/_f_a_git_commit_checkout.sh),ctrl-u:preview-page-up,ctrl-d:preview-page-down" \
  --height=100% --preview-window=right,50%:wrap
