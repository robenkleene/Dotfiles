#!/usr/bin/env bash

set -euo pipefail

grep -E --only-matching ".*:[0-9]+:" | sed "s/^ *--> *//"
#                                      ^ Rust prefixes errors with `-->`
