#!/usr/bin/env bash

set -euo pipefail

exec pandoc --standalone -f markdown+smart -t rtf
