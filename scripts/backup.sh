#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${1-}" ]]; then
  exec ~/.bin/backup_file "$@"
else
  exec ~/.bin/backup_text
fi
