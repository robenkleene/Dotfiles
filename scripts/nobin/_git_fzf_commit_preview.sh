#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

separator=""
if [[ "$#" -eq 1 ]]; then
  separator=" -- "
fi

hash=$(cat | head -1 | grep --only-matching "[a-f0-9]\{7\}")
git show --color=always "$hash" ${separator}"${1}"
