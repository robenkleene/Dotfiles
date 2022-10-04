#!/usr/bin/env bash

set -e

if [[ -z "$1" ]]; then
  echo "No file specified" >&2
  exit 1
fi

cat "$1" | ~/.bin/safecopy
