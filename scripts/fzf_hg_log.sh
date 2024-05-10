#!/usr/bin/env bash

set -euo pipefail

if [[ -z "${EDITOR:-}" || "${EDITOR:-}" = "nvim" ]]; then
  exec fzf --ansi --multi --preview "echo {} | ~/.bin/f_hash | xargs hg --color=always log --patch --rev" \
    --bind="enter:become(printf \"%s\n\" {+} | ~/.bin/f_hash),alt-u:become(echo {} | ~/.bin/f_hash | head -n1 | xargs hg update),alt-e:execute(echo {} | ~/.bin/f_hash | head -n1 | xargs hg log --patch --rev | ${EDITOR:-vim} -)"
else
  exec fzf --ansi --multi --preview "echo {} | ~/.bin/f_hash | head -n1 | hg --color=always log --patch --rev" \
    --bind="enter:become(printf \"%s\n\" {+} | ~/.bin/f_hash),alt-u:become(echo {} | ~/.bin/f_hash | head -n1 | xargs hg update)"
fi
