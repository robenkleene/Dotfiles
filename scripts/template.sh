#!/usr/bin/env bash

set -euo pipefail

path="$1"
extension="${path##*.}"

cat $(find ~/Developer/Snippets/Templates -type f -name "*.${extension}")
