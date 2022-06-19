#!/usr/bin/env bash

set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

dir=${PWD##*/}

exit 1
git archive --format=tar --prefix="$dir" v1.4.0 | gzip >"$dir"
