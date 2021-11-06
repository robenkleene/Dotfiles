#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1
./packages/install.sh -f "$@"
