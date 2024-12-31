#!/usr/bin/env bash

set -euo pipefail

exec pandoc -f markdown -t rtf
