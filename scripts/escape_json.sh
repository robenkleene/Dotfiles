#!/usr/bin/env bash

set -euo pipefail

python -c 'import json,sys; print(json.dumps(sys.stdin.read()))' | sed 's/\\n/\\n/g'
# jq -R -s '.' | sed 's/\\n/\\\n/g'
