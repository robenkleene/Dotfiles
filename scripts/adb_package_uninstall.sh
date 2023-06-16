#!/usr/bin/env bash

set -euo pipefail
exec adb uninstall "$@"
