#!/usr/bin/env bash

export LANG=C
export LC_CTYPE=C

set -euo pipefail

exec ~/.bin/t_md_rtf | ~/.bin/safecopy
