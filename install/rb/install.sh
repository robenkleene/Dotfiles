#!/usr/bin/env bash

set -eo pipefail

if [[ -f $HOMEBREW_DIR/share/chruby/chruby.sh ]]; then
  source "$HOMEBREW_DIR/share/chruby/chruby.sh"
else
  echo "Error: chruby not found" >&2
  exit 1
fi

chruby 3.0.2 || ruby-install ruby 3.0.2

cd "$(dirname "$0")" || exit 1
