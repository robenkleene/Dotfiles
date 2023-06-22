#!/usr/bin/env bash

set -euo pipefail

export CLICOLOR=1
export SHELL=sh
exec ~/.bin/z_list_parentdir | fzf --exact --no-sort --bind 'ctrl-f:preview-page-down,ctrl-b:preview-page-up' --cycle --info=inline --layout=reverse --tabstop=1 --exit-0 --preview="~/.bin/nobin/_fzf_preview.sh {}" --preview-window '<30(bottom,30%)'
