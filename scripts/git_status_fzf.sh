#!/usr/bin/env bash

set -euo pipefail

git status --short | awk '{$1=$1};1' | \
  fzf --nth 2.. --no-sort --ansi --reverse --multi \
  --preview "echo {} | ~/.bin/nobin/_f_a_git_file_preview.sh" \
  --bind="ctrl-e:become($EDITOR {+2..}),ctrl-x:execute-silent(echo {+2..} | ~/.bin/safecopy)+accept,alt-p:become(echo {+} | ~/.bin/nobin/_f_a_git_file_preview.sh),ctrl-u:preview-page-up,ctrl-d:preview-page-down" \
  --height=20 --preview-window=right,50%:wrap
