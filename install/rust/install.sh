#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

# `-y`: Disable confirmation
# `--no-modify-path`: Don't customize path
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
./crates/install.sh
