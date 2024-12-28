#!/usr/bin/env bash

set -euo pipefail

exec pandoc -f html -t gfm-raw_html
