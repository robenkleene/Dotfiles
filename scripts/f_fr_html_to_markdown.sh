#!/usr/bin/env bash

set -euo pipefail

exec pandoc -f html -t markdown
