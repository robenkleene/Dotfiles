#!/usr/bin/env bash

set -e

# This doesn't work because we need an exact version of bundler
# gem list -i "^bundler$" >/dev/null || gem install bundler

if [[ -f $HOME"/.bundle/config" ]]; then
  echo "Error: ~/.bundle/config exists which can interfere with this install" >&2
  echo "E.g., if it includes a path, that path will override installing to system" >&2
  exit 1
fi

cd "$(dirname "$0")" || exit 1
# gem install bundler -v "$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1)"
bundle install
