#!/usr/bin/env bash

set -e

if [[ $# -eq 0 ]]; then
  exec open -a "Emacs.app" .
else
  exec open -a "Emacs.app" "$@"
fi
