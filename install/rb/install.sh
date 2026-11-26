#!/usr/bin/env bash

set -eo pipefail

if [[ -f $HOMEBREW_DIR/share/chruby/chruby.sh ]]; then
  source "$HOMEBREW_DIR/share/chruby/chruby.sh"
else
  echo "Error: chruby not found" >&2
  exit 1
fi

chruby 4.0.10 || ruby-install ruby 4.0.10
ln -sfn ruby-4.0.10 ~/.rubies/current

cd "$(dirname "$0")" || exit 1
