#!/usr/bin/env bash

set -euo pipefail

grep -v "^-" | sed 's/^[+ ]//'
