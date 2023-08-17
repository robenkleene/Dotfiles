#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

separator=" ."
if [[ -n "${1-}" ]]; then
  separator=" -- "
fi

git log --graph --color=always --format="%C(auto)%h %s%d"${separator}"${1}" | \
  fzf --no-sort --ansi --reverse --multi \
  --preview "echo {} | ~/.bin/nobin/_fzf_preview_git_commit.sh \"$1\"" \
  --bind="ctrl-x:execute-silent(echo {2} | ~/.bin/safecopy)+accept,alt-p:become(echo {} | ~/.bin/nobin/_fzf_preview_git_commit.sh \"$1\"),alt-u:become(echo {} | ~/.bin/nobin/_fzf_checkout_git_commit.sh \"$1\"),ctrl-u:preview-page-up,ctrl-d:preview-page-down" \
  --height=20 --preview-window=right,50%:wrap
