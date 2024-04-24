#!/usr/bin/env bash

set -euo pipefail

exec fzf --delimiter=':' --nth=2.. --ansi --reverse --keep-right --multi \
  --preview 'bat --style=header --color=always --line-range {2}: --highlight-line {2} {1}' \
  --bind="alt-e:become(printf \"%s\n\" {+} | cut -d':' -f 1 | tr '\n' '\0' | xargs -0 -o ${EDITOR:-vim}),alt-g:execute(${EDITOR:-vim} +{2} {1}),ctrl-v:preview-page-up,alt-v:preview-page-down,alt-a:toggle-all" \
  --height=20 --preview-window=right,50%:wrap
