#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

exec emacs --script packages.el
