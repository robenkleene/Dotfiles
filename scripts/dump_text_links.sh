#!/usr/bin/env bash

set -euo pipefail

rg --no-line-number --no-filename --only-matching "\[([^\[\]]*)\]\((http.*?)\)" ~/Text ~/Documentation
