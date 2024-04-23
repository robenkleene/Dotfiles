#!/usr/bin/env bash

set -euo pipefail

while IFS= read -r line; do
  echo "${line%%:*}"
done
