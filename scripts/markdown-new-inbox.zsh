#!/usr/bin/env zsh

set -e

if [ "$#" -ne 1 ]; then
    echo "Wrong number of arguments" >&2
    exit 1
fi

if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi

title=$1
markdown-new-file "$title" "$INBOX_DIRECTORY"
