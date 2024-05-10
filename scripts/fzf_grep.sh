#!/usr/bin/env bash

set -euo pipefail

if [[ -z "$EDITOR" || "$EDITOR" = "nvim" ]]; then
  exec fzf --delimiter=':' --nth=2.. --ansi --keep-right --multi \
    --preview 'bat --style=header --color=always --line-range {2}: --highlight-line {2} {1}' \
    --bind="alt-e:execute(printf \"%s\n\" {+} | ${EDITOR:-vim} -c 'cbuffer | bprevious | bdelete' -),alt-a:select-all,alt-d:deselect-all"
else
  exec fzf --delimiter=':' --nth=2.. --ansi --keep-right \
    --preview 'bat --style=header --color=always --line-range {2}: --highlight-line {2} {1}' \
    --bind="alt-e:execute(${EDITOR:-vim} +{2} {1}),alt-a:select-all,alt-d:deselect-all"
fi
