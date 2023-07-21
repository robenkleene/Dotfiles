#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

separator=" ."
if [[ -n "${1-}" ]]; then
  separator=" -- "
fi

git log --graph --color=always --format="%C(auto)%h %s%d"${separator}"${1}" | \
  fzf --no-sort --ansi \
  --preview "echo {} | ~/.bin/nobin/_fzf_preview_git_commit.sh \"$1\"" \
  --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' \
  ${FZF_DEFAULT_PREVIEW_OPTS:-} | grep --only-matching "[a-f0-9]\{7\}" | sed 's/\s.*$//'
