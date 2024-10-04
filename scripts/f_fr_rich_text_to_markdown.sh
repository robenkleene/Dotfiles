#!/usr/bin/env bash

set -euo pipefail

exec pandoc -f rtf -t markdown
