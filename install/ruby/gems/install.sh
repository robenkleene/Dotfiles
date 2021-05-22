#!/usr/bin/env bash

set -e

gem list -i "^bundler$" >/dev/null || gem install bundler

cd "$(dirname "$0")" || exit 1
bundle install --system
