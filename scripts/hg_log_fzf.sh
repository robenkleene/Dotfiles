#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

hg log --template '{node|short} {author|user}: {desc|strip|firstline}\n' --limit 100 "$1" | \
  fzf --nth 2.. --no-sort --ansi --reverse \
  --preview "echo {} | ~/.bin/nobin/_fzf_preview_hg_rev.sh \"$1\"" \
  --bind="ctrl-x:execute-silent(echo {1} | ~/.bin/safecopy)+accept,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" \
  --height=20 --preview-window=right,50%:wrap
