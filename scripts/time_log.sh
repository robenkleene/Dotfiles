#!/usr/bin/env bash

set -euo pipefail

echo "$(date)", "$1" > "${2:-$HOME/Text/journal/time.csv}"
