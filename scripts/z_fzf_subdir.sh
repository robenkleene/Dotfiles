#!/usr/bin/env bash

set -euo pipefail

export CLICOLOR=1
export SHELL=sh
exec ~/.bin/z_list_subdir | fzf --exact --no-sort --bind 'ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' --cycle --info=inline --layout=reverse --tabstop=1 --exit-0 --preview="~/.bin/nobin/_fzf_preview.sh {}" --preview-window '<30(bottom,30%)'
