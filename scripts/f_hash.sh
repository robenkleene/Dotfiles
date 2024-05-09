#!/usr/bin/env bash

set -euo pipefail

# `[^A-Z]` removes some things that look like hashes, like `T0000000`
grep --only-matching "[^A-Z][a-f0-9]\{9\}[a-f0-9]*" | sed 's/\s.*$//'
