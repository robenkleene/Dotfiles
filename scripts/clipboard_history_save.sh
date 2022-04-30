#!/usr/bin/env bash

set -euo pipefail

clipboard_history="$HOME/.clipboard_history"
max_line_bytes=10000
max_file_bytes=10000000
resize_file_bytes=1000000

{ echo; head --bytes=$max_line_bytes; } | tr '\n' '\0' | grep -a . >> "$clipboard_history"
temp_file=$(mktemp "${TMPDIR:-/tmp}/clipboard_history.XXXX")
# awk on macOS doesn't strips everything after a null byte
# tail -n "$max_size" < "$clipboard_history" | awk '!x[$0]++' > "$temp_file"; mv "$temp_file" "$clipboard_history"
if [[ $(stat -f %z "$clipboard_history") -gt ${max_file_bytes} ]]; then
  tail --bytes "$resize_file_bytes" < "$clipboard_history" > "$temp_file"; mv "$temp_file" "$clipboard_history"
fi
