#!/usr/bin/env bash

set -euo pipefail

export CLICOLOR=1
export SHELL=sh
exec ~/.bin/z_list_subdir | fzf --exact --no-sort --bind=ctrl-z:ignore,btab:up,tab:down --cycle --keep-right --border=sharp --height=45% --info=inline --layout=reverse --tabstop=1 --exit-0 --preview="~/.bin/nobin/_fzf_preview.sh" --preview-window=down,30%,sharp
