#!/usr/bin/env bash

set -euo pipefail

sed -E 's/[[:space:]]+/, /g'
