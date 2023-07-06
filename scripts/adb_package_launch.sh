#!/usr/bin/env bash

set -euo pipefail
exec adb shell am start -n "$1/$1.MainActivity"
