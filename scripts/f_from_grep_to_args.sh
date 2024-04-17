#!/usr/bin/env bash

set -euo pipefail

while IFS=: read -r filename lineno rest
do
    safe_filename=$(printf '%q' "$filename")
    echo "+${lineno} ${safe_filename}"
done
