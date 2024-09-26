#!/usr/bin/env bash

set -euo pipefail

if [[ -f "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient" ]]; then
  exec "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient" "$@"
elif [[ -f "$HOME/.brew/bin/emacsclient" ]]; then
  exec "$HOME/.brew/bin/emacsclient" "$@"
elif [[ -f "/usr/bin/emacsclient" ]]; then
  exec "/usr/bin/emacsclient" "$@"
fi
