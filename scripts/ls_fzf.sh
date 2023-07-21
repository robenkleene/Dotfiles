#!/usr/bin/env bash

set -euo pipefail

export CLICOLOR=1
export SHELL=sh
# We're not using `z_list_parentdir`, z version probably not worth the
# additional time to run?
set -x
~/.bin/find_ls "$@" | fzf --ansi --multi --preview="~/.bin/nobin/_fzf_preview_file.sh {}" \
  --bind='ctrl-v:become(vim {+}),ctrl-x:execute-silent(echo {+} | pbcopy)+accept,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' \
  --height=20 --preview-window=right,50%:wrap       
