#!/usr/bin/env bash

set -euo pipefail

for arg in "$@"; do
  dirname "$arg"
done
