#!/usr/bin/env bash

set -euo pipefail

urls=''
while read -r url; do
  urls+=" $url"
done <<< "$(~/.bin/f_url)"
open${urls}
