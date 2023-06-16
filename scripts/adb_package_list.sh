#!/usr/bin/env bash

set -euo pipefail
exec adb shell cmd package list packages "$@" | cut -d: -f 2
