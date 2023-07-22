#!/usr/bin/env bash

set -euo pipefail

fzf --ansi --multi --preview "$HOME/.bin/nobin/_fzf_preview_file.sh {}" \
  --bind="ctrl-e:become($EDITOR {+}),alt-p:become(~/.bin/nobin/_fzf_preview_file.sh {+}),ctrl-x:execute-silent(echo {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" \
  --height=20 --preview-window=right,50%:wrap
