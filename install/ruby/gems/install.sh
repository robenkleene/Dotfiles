#!/usr/bin/env bash

set -e

# This doesn't work because we need an exact version of bundler
# gem list -i "^bundler$" >/dev/null || gem install bundler

cd "$(dirname "$0")" || exit 1
# gem install bundler -v "$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1)"
bundle install --system
