#!/usr/bin/env bash

set -euo pipefail

if [[ -z "$EDITOR" || "$EDITOR" = "nvim" ]]; then
  exec fzf --ansi --preview "echo {} | ~/.bin/f_hash | xargs hg --color=always log --patch --rev" \
    --bind="alt-u:become(echo {} | ~/.bin/f_hash | head -n1 | xargs hg update),alt-e:become(echo {} | ~/.bin/f_hash | head -n1 | xargs hg log --patch --rev | ${EDITOR:-vim} -)"
else
  exec fzf --ansi --preview "echo {} | ~/.bin/f_hash | head -n1 | hg --color=always log --patch --rev" \
    --bind="alt-u:become(echo {} | ~/.bin/f_hash | head -n1 | xargs hg update)"
fi
