#!/usr/bin/env bash

set -euo pipefail
for var in "$@"; do
  adb shell am force-stop "$var"
done
