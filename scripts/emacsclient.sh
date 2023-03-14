#!/usr/bin/env bash

set -euo pipefail

if [[ -f "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient" ]]; then
  exec "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient" "$@"
else
  exec "$HOME/.brew/bin/emacsclient" "$@"
fi
