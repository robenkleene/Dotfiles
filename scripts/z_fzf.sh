#!/usr/bin/env bash

set -euo pipefail

# exec ~/.brew/bin/zoxide query --interactive "$@"
exec ~/.bin/z_list | fzf --ansi --multi --reverse --preview="~/.bin/nobin/_fzf_preview_file.sh {}" \
  --bind='ctrl-e:become(vim {+}),ctrl-x:execute-silent(echo {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' \
  --height=20 --preview-window=right,50%:wrap       
