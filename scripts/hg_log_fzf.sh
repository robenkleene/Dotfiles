#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

hg log --template '{node|short} {author|user}: {desc|strip|firstline}\n' --limit 100 "$1" | \
  fzf --no-sort --ansi \
  --preview "echo {} | ~/.bin/nobin/_fzf_preview_hg_rev.sh \"$1\"" \
  ${FZF_DEFAULT_PREVIEW_OPTS:-} | grep --only-matching "[a-f0-9]\{7\}" | sed 's/\s.*$//'
