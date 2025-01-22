#!/usr/bin/env bash

export LANG=C
export LC_CTYPE=C

set -euo pipefail

# For some reason using `safecopy` doesn't work here
exec ~/.bin/t_md_rtf | pbcopy
