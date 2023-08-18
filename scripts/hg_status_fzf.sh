#!/usr/bin/env bash

set -euo pipefail

hg status 2>/dev/null | awk '{$1=$1};1' | \
  fzf --no-sort --ansi --reverse --multi \
  --preview="~/.bin/nobin/_f_a_hg_file_diff.sh {+}" \
  --bind="ctrl-e:become(${EDITOR:-vim} {+2..}),alt-p:become(~/.bin/nobin/_f_a_hg_file_diff.sh {+}),ctrl-u:preview-page-up,ctrl-d:preview-page-down,ctrl-a:toggle-all" \
  --height=20 --preview-window=right,50%:wrap
