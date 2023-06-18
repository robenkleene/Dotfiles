#!/usr/bin/env bash

set -euo pipefail
hash=$(cat | head -1 | grep --only-matching "[a-f0-9]\{7\}")
git show --color=always "$hash"
