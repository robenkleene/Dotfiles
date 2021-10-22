#!/usr/bin/env bash

set -eo pipefail

cmd="rg --no-filename --only-matching \"\[([^\[\]]*)\]\((http.*?)\)\" ~/Text ~/Documentation"
fzfcmd="$(__fzfcmd)"

eval "$cmd" | $fzfcmd | ~/.bin/urls_open
