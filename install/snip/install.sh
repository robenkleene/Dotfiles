#!/usr/bin/env bash

set -euo pipefail

cd $(dirname "$0" || exit 1)

./snippets-sync.sh -df
./snippets-export.rb -of
