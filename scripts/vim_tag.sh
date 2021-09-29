#!/usr/bin/env bash

set -euo pipefail

if [[ "$#" -ne 1 ]]; then
    echo "Error: Wrong number of arguments" >&2
    exit 1
fi

exec $VIM_COMMAND -c "tag $1"
