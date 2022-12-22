#!/usr/bin/env bash

set -euo pipefail

if ! command -v jq &> /dev/null; then
  echo "jq not found" >&2
  exit 1
fi

if [[ ! -d $HOME"/.config/Code/User/snippets" ]]; then
  echo "Code snippets dir ~/.config/Code/User/snippets not found" >&2
  exit 1
fi

if [[ ! -d $HOME"/.emacs.d/snippets" ]]; then
  echo "YASnippet dir ~/.emacs.d/snippets not found" >&2
  exit 1
fi

