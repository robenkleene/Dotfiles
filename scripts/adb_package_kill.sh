#!/usr/bin/env bash

set -euo pipefail
for var in "$@"; do
  adb shell am kill "$var"
done
