#!/usr/bin/env bash

# Allow unbound variable for $1
set -eo pipefail

hash=$(cat | grep --only-matching "[a-f0-9]\{9\}" | sed 's/\s.*$//' | head -1)
hg update "$hash"
