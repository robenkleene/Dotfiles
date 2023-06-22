#!/usr/bin/env bash

set -euo pipefail
hash=$(cat | head -1 | grep --only-matching "[a-f0-9]\{7\}")
# No idea why this only works as a separate step
hash=$(echo $hash | cut -d ' ' -f1)
hg show --color=always "$hash"

