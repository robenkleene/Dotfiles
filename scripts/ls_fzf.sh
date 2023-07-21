#!/usr/bin/env bash

set -euo pipefail

export CLICOLOR=1
export SHELL=sh
# We're not using `z_list_parentdir`, z version probably not worth the
# additional time to run?
exec ~/.bin/find_ls -f "$@" | fzf --ansi --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' --preview="~/.bin/nobin/_fzf_preview_file.sh {}" --preview-window '<30(bottom,30%):wrap'
