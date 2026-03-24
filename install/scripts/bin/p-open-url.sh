#!/usr/bin/env bash

set -euo pipefail

urls=''
while read -r url; do
  urls+=" $url"
done <<< "$(~/.bin/f_url)"
if [[ "$(uname)" = "Darwin" ]]; then
  open${urls}
elif [[ "$(uname)" = "Linux" ]]; then
  echo${urls}
fi
