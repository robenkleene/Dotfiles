#!/usr/bin/env bash

set -euo pipefail

# macOS dirname does not handle multiple parameters, so dirnname $(ls) fails
# with `usage: dirname path`. This wrapper makes it behave like dirname on
# Linux which supports multiple parameters fine.

for arg in "$@"; do
  /usr/bin/dirname "$arg"
done
