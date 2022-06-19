#!/usr/bin/env bash

set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

dir=${PWD##*/}
git archive --format=tar --prefix="$dir" "$dir" | gzip >"$dir"
