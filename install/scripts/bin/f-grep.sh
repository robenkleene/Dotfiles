#!/usr/bin/env bash

set -euo pipefail

grep --extended-regexp --only-matching "[^: ]+:[0-9]+:?[0-9]+:?"
