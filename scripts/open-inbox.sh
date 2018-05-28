#!/usr/bin/env zsh

set -e

if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi

open "$INBOX_DIRECTORY"
