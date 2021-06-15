#!/usr/bin/env bash

set -eo pipefail

if [[ -f $HOMEBREW_DIR/share/chruby/chruby.sh ]]; then
  source "$HOMEBREW_DIR/share/chruby/chruby.sh"
else
  echo "Error: chruby not found" >&2
  exit 1
fi

chruby 2.5.3 || ruby-install ruby 2.5.3

cd "$(dirname "$0")" || exit 1
./gems/install.sh "$@"
