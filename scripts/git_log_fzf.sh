#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

separator=" ."
if [[ -n "${1-}" ]]; then
  separator=" -- "
fi

git log --graph --color=always --format="%C(auto)%h %s%d"${separator}"${1}" | \
  fzf --no-sort --ansi --reverse \
  --preview "echo {} | ~/.bin/nobin/_fzf_preview_git_commit.sh \"$1\"" \
  --bind="ctrl-x:execute-silent(echo {} | ~/.bin/safecopy)+accept,alt-p:become(echo {} | ~/.bin/nobin/_fzf_preview_git_commit.sh \"$1\"),ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" \
  --height=20 --preview-window=right,50%:wrap
