#!/usr/bin/env bash

set -euo pipefail

exec pandoc -f rtf -t gfm-raw_html
