#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Wrong number of arguments" >&2
    exit 1
fi

name="$1"
if [[ -z "$name" ]]; then
    echo "Invalid name" >&2
    exit 1
fi

~/.bin/markdown_new_file "$name" ~/Documents/Text/Notes/People/
