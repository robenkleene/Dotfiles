#!/usr/bin/env bash

set -euo pipefail

if [[ $# -gt 0]]; then
  echo "$@" | ~/.bin/f_slug
else
  ~/.bin/f_slug
fi
