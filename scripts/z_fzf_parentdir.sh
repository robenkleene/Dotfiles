#!/usr/bin/env bash

set -euo pipefail

export CLICOLOR=1
export SHELL=sh
# We're not using `z_list_parentdir`, z version probably not worth the
# additional time to run?
exec ~/.bin/list_parentdir | fzf --exact --no-sort --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' --cycle --info=inline --layout=reverse --tabstop=1 --exit-0 --preview="~/.bin/nobin/_fzf_preview.sh {}" --preview-window '<30(bottom,30%)'
