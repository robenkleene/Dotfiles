#!/usr/bin/env bash

set -e

if [ "$#" -ne 1 ]; then
    echo "Wrong number of arguments" >&2
    exit 1
fi

title="$1"
if [[ -z "$title" ]]; then
    echo "Invalid title" >&2
    exit 1
fi
file=$(~/.bin/inbox_new "$title")
eval "$EDITOR \"$file\""
