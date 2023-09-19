#!/usr/bin/env bash

set -euo pipefail

fzf --ansi --reverse --keep-right --multi --preview "$HOME/.bin/nobin/_preview_file.sh {}" \
  --bind="ctrl-e:become(${EDITOR:-vim} {+}),ctrl-o:become(open {+}),alt-p:become(~/.bin/nobin/_preview_file.sh {+}),ctrl-x:execute-silent(echo {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down,ctrl-a:toggle-all" \
  --height=20 --preview-window=right,50%:wrap
