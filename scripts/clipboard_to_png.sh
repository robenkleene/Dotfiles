#!/usr/bin/env bash

set -euo pipefail

osascript -e "get the clipboard as «class PNGf»" | sed "s/«data PNGf//; s/»//" | xxd -r -p > x.png
