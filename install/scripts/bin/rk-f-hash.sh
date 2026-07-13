#!/usr/bin/env bash

set -euo pipefail

# `[^A-Z]` removes some things that look like hashes, like `T0000000`
# `[^A-Z]` was removed because it wasn't working on Linux
grep --extended-regexp --only-matching "[a-f0-9]{9}[a-f0-9]*" | sed 's/\s.*$//'
