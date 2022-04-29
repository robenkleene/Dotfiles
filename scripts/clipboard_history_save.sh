#!/usr/bin/env bash

set -euo pipefail

clipboard_history="$HOME/.clipboard_history"
max_size=10000

head --bytes=10000 | tr '\n' '\0' >> "$clipboard_history"
temp_file=$(mktemp "${TMPDIR:-/tmp}/clipboard_history.XXXX")
tail -n "$max_size" < "$clipboard_history" | awk '!x[$0]++' > "$temp_file"; mv "$temp_file" "$clipboard_history"
echo >> "$clipboard_history"
