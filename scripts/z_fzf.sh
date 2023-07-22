#!/usr/bin/env bash

set -euo pipefail

# exec ~/.brew/bin/zoxide query --interactive "$@"
exec ~/.bin/z_list | fzf --ansi --reverse --multi --no-sort --preview="~/.bin/nobin/_fzf_preview_file.sh {}" \
  --bind="ctrl-e:become($EDITOR {+}),ctrl-x:execute-silent(echo {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" \
  --height=20 --preview-window=right,50%:wrap
