#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

hg log --template '{node|short} {author|user}: {desc|strip|firstline}\n' --limit 100 "$1" | \
  fzf --nth 2.. --no-sort --ansi --reverse --multi \
  --preview "echo {} | ~/.bin/nobin/_f_a_hg_rev_preview.sh \"$1\"" \
  --bind="alt-p:become(echo {} | ~/.bin/nobin/_f_a_hg_rev_preview.sh \"$1\"),alt-u:become(echo {} | ~/.bin/nobin/_f_a_hg_rev_update.sh),ctrl-u:preview-page-up,ctrl-d:preview-page-down,ctrl-a:toggle-all" \
  --height=100% --preview-window=right,50%:wrap
