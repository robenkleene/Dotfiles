#!/usr/bin/env bash

set -euo pipefail

chruby 2.5.3 || ruby-install ruby 2.5.3

cd "$(dirname "$0")" || exit 1
./gems/install.sh
