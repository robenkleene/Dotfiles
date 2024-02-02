#!/usr/bin/env bash

set -euo pipefail

temp_file=$(mktemp)
cat > "$temp_file"
# Put an empty line in front to make it easier to cut and paste without copying the copy mode line indicator
tmux run-shell "echo; cat $temp_file"
rm "$temp_file"
