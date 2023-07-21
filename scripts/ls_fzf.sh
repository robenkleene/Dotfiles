#!/usr/bin/env bash

set -euo pipefail

export CLICOLOR=1
export SHELL=sh
# We're not using `z_list_parentdir`, z version probably not worth the
# additional time to run?
exec ~/.bin/find_ls "$@" | fzf --ansi --multi --preview="~/.bin/nobin/_fzf_preview_file.sh {}" ${FZF_DEFAULT_PREVIEW_OPTS:-}
