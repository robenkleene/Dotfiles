#!/usr/bin/env bash

set -euo pipefail

if [[ -z "$EDITOR" || "$EDITOR" = "nvim" ]]; then
  exec fzf --ansi --reverse --preview "echo {} | ~/.bin/f_hash | xargs hg --color=always show" \
    --bind="enter:become(echo {} | ~/.bin/f_hash | xargs hg update),alt-e:execute(echo {} | ~/.bin/f_hash | xargs hg show | ${EDITOR:-vim} -)"
else
  exec fzf --ansi --reverse --preview "echo {} | ~/.bin/f_hash | xargs hg --color=always show" \
    --bind="enter:become(echo {} | ~/.bin/f_hash | xargs hg update)"
fi
