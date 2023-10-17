#!/usr/bin/env bash

set -euo pipefail

grep --only-matching "[a-f0-9]\{9\}[a-f0-9]*" | sed 's/\s.*$//'
