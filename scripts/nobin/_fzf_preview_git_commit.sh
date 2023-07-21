#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

separator=""
if [[ -n "${1-}" ]]; then
  separator=" -- "
fi

hash=$(cat | grep --only-matching "[a-f0-9]\{7\}" | sed 's/\s.*$//' | head -1)
if [[ -z "${hash-}" ]]; then
  echo "Error: No hash found" >&2
  exit 1
fi
git show --color=always "$hash"${separator}"${1}"
