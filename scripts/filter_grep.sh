#!/usr/bin/env bash

set -euo pipefail

grep -E --only-matching ".*:[0-9]+:"
