#!/usr/bin/env bash

set -e

if [ "$#" -ne 1 ]; then
    echo "Wrong number of arguments" >&2
    exit 1
fi

title="$1"
~/.bin/markdown_new_file "$title" ~/Documents/Text/Inbox/
