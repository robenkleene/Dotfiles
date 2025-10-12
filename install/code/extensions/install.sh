#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

while read extension; do
  code --install-extension "$extension"
done <extensions.txt
