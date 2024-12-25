#!/usr/bin/env bash

set -euo pipefail

grep -E --only-matching "\[[^][]+\]\([^)]*\)"