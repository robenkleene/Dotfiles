#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

separator=""
if [[ -n "${1-}" ]]; then
  separator=" -- "
fi

hash=$(cat | head -1 | grep --only-matching "[a-f0-9]\{7\}")
if [[ -z "${hash-}" ]]; then
  echo "Error: No hash found" >&2
  exit 1
fi
echo "hash = $hash"
echo "separator = $separator"
git show --color=always "$hash"${separator}"${1}"
