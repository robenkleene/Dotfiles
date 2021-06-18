#!/usr/bin/env bash

set -euo pipefail

# This was moved from an alias because it's useful in one liners
# E.g., fd --hidden "release.yml" --exec gprpr -C {//}
exec ~/.bin/source_control_open_site "$@"
