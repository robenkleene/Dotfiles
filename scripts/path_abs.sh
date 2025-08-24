#!/usr/bin/env bash

set -euo pipefail

subpath=$(realpath --relative-to="$HOME" "$@")
echo -n "~/$subpath"
