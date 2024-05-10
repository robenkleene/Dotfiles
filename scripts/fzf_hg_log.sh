#!/usr/bin/env bash

set -euo pipefail

if [[ -z "$EDITOR" || "$EDITOR" = "nvim" ]]; then
  exec fzf --ansi --preview "echo {} | ~/.bin/f_hash | xargs hg --color=always show" \
    --bind="alt-e:execute(echo {} | ~/.bin/f_hash | xargs hg update),alt-e:execute(echo {} | ~/.bin/f_hash | xargs hg show | ${EDITOR:-vim} -)" | ~/.bin/f_hash
else
  exec fzf --ansi --preview "echo {} | ~/.bin/f_hash | xargs hg --color=always show" \
    --bind="alt-e:execute(echo {} | ~/.bin/f_hash | xargs hg update)" | ~/.bin/f_hash
fi
