#!/usr/bin/env bash

set -e

if [[ "$#" -ne 1 ]]; then
    echo "Wrong number of arguments" >&2
    exit 1
fi

git checkout "${1}"~1
git show "${1}" | git apply

