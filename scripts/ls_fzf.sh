#!/usr/bin/env bash

set -euo pipefail

export CLICOLOR=1
export SHELL=sh

# Only allow files because `_fzf_preview_file` can only support `--multi` with files
~/.bin/find_ls -f "$@" | fzf --ansi --reverse --multi --preview="~/.bin/nobin/_fzf_preview_file.sh {}" \
  --bind="ctrl-e:become($EDITOR {+}),alt-p:become(~/.bin/nobin/_fzf_preview_file.sh {+}),ctrl-x:execute-silent(echo {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" \
  --height=20 --preview-window=right,50%:wrap
