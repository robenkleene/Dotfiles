#!/usr/bin/env bash

set -euo pipefail
exec adb shell am force-stop "$@"
