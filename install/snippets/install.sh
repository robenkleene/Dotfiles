#!/usr/bin/env bash

set -euo pipefail

cd $(dirname "$0" || exit 1)

./snippets_export.rb -of
./snippets_sync.sh -f
