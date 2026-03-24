#!/usr/bin/env bash

set -euo pipefail

# `awk '{print $0}'` force a new line
awk '{print $0}' | while IFS=: read -r filename lineno rest
do
    safe_filename=$(printf '%q' "$filename")
    echo -n "+${lineno} ${safe_filename}"
done
