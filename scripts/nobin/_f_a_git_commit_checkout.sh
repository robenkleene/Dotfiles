#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

hash=$(cat | grep --only-matching "[a-f0-9]\{7\}" | sed 's/\s.*$//' | head -1)
git checkout "$hash"
