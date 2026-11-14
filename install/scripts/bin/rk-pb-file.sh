#!/usr/bin/env bash

set -euo pipefail

# `clipboard info` lists each type on the clipboard with its size, e.g., `«class PNGf», 366217, TIFF picture, 306394`
clipboard_info=$(osascript -e 'clipboard info')

image_class=""
extension=""
# The first `<class>:<extension>` pair found wins, so `«class PNGf»` is preferred when the clipboard offers several image types
for candidate in "«class PNGf»:png" "JPEG picture:jpg" "TIFF picture:tiff" "GIF picture:gif"; do
  if [[ $clipboard_info == *"${candidate%:*}"* ]]; then
    image_class=${candidate%:*}
    extension=${candidate##*:}
    break
  fi
done

if [[ -z "$image_class" ]]; then
  if [[ $clipboard_info == *"«class utf8»"* ]]; then
    extension="txt"
  else
    echo "Error: No image or text on the clipboard" >&2
    exit 1
  fi
fi

if [[ $# -ge 1 ]]; then
  path=$1
else
  # `mktemp` reserves a unique name, which is then swapped for the same name with `.$extension` added
  placeholder=$(mktemp "clipboard-XXXXXX")
  path=$placeholder.$extension
  rm "$placeholder"
fi

if [[ -n "$image_class" ]]; then
  # `POSIX file` doesn't resolve relative paths against the working directory, so make `path` absolute
  if [[ $path == /* ]]; then
    absolute_path=$path
  else
    absolute_path=$PWD/$path
  fi
  # `set eof f to 0` truncates an existing file, otherwise `write` leaves its trailing bytes in place
  osascript - "$absolute_path" <<EOF
on run argv
  set f to open for access POSIX file (item 1 of argv) with write permission
  try
    set eof f to 0
    write (the clipboard as $image_class) to f
  on error message
    close access f
    error message
  end try
  close access f
end run
EOF
else
  # `LANG=en_US.UTF-8` makes `pbpaste` output UTF-8 instead of mangling non-ASCII text under the `C` locale
  LANG=en_US.UTF-8 pbpaste > "$path"
fi

echo "$path"
