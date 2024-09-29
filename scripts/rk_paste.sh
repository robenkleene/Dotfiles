#!/usr/bin/env bash

set -euo pipefail

# For some reason fish shell doesn't allow backgrounding vim when piping from
# an alias, so instead make a wrapper script

exec ~/.bin/safepaste "$@"
