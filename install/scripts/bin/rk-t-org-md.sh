#!/usr/bin/env bash

set -euo pipefail

pandoc -f org -t gfm-raw_html
