#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

separator=""
if [[ -n "${1-}" ]]; then
  separator=" -- "
fi

hashes=$(cat | grep --only-matching "[a-f0-9]\{7\}" | sed 's/\s.*$//')
if [[ -z "${hashes:-}" ]]; then
  echo "Error: No hash found" >&2
  exit 1
fi

IFS=$'\n'
for hash in $hashes; do
  eval git show --color=always "$hash"${separator}"${1}"
done
