#!/usr/bin/env bash

set -euo pipefail

parameter=""
if [[ "${THEME:-}" = "light" ]]; then
  parameter="--light"
elif [[ "${THEME:-}" = "dark" ]]; then
  parameter="--dark"
fi
exec "$HOME/.brew/bin/delta" "$parameter" "$@"
