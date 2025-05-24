#!/usr/bin/env bash

set -euo pipefail

cd $(dirname "$0" || exit 1)

./snippets_sync.sh -df
./snippets_export.rb -of
