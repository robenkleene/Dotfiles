#!/usr/bin/env bash

set -euo pipefail

# `~/.bin/f_hash` only print hashes which is what might be useful for another command
# `|| true` prevent a non-zero exit status if a binding replaces the `fzf` process
if [[ -z "$EDITOR" || "$EDITOR" = "nvim" ]]; then
  exec fzf --ansi --preview "echo {} | ~/.bin/f_hash | xargs hg --color=always show" \
    --bind="alt-u:become(echo {} | ~/.bin/f_hash | xargs hg update),alt-e:execute(echo {} | ~/.bin/f_hash | xargs hg show | ${EDITOR:-vim} -)" | ~/.bin/f_hash || true
else
  exec fzf --ansi --preview "echo {} | ~/.bin/f_hash | xargs hg --color=always show" \
    --bind="alt-u:become(echo {} | ~/.bin/f_hash | xargs hg update)" | ~/.bin/f_hash || true
fi
