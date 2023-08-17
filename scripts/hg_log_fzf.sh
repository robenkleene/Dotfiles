#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

hg log --template '{node|short} {author|user}: {desc|strip|firstline}\n' --limit 100 "$1" | \
  fzf --nth 2.. --no-sort --ansi --reverse --multi \
  --preview "echo {} | ~/.bin/nobin/_fzf_preview_hg_rev.sh \"$1\"" \
  --bind="alt-p:become(echo {} | ~/.bin/nobin/_fzf_preview_hg_rev.sh \"$1\"),alt-u:become(echo {} | ~/.bin/nobin/_fzf_update_hg_rev.sh),ctrl-u:preview-page-up,ctrl-d:preview-page-down" \
  --height=100% --preview-window=right,50%:wrap
