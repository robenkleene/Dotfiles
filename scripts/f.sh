#!/usr/bin/env bash

set -euo pipefail

if [[ ! -t 0 ]]; then
  fzf --ansi --reverse --keep-right --multi --preview "$HOME/.bin/nobin/_preview_file.sh {}" \
    --bind="ctrl-e:become(${EDITOR:-vim} {+}),alt-p:become(~/.bin/nobin/_preview_file.sh {+}),ctrl-x:execute-silent(echo {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" \
    --height=20 --preview-window=right,50%:wrap
else
  exec fd --color=always "$@" | fzf --ansi --reverse --keep-right --multi --preview "$HOME/.bin/nobin/_preview_file.sh {}" \
    --bind="ctrl-e:become(${EDITOR:-vim} {+}),alt-p:become(~/.bin/nobin/_preview_file.sh {+}),ctrl-x:execute-silent(echo {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" \
    --height=20 --preview-window=right,50%:wrap
fi
