#!/usr/bin/env bash

set -e

# `tr -dc '[:alnum:]\r\n. '`: Strip non-alphanumeric characters
# `tr -s ' '`: Consolidate spaces to one space
# `tr '[A-Z]' '[a-z]'`: Lowercase
# `tr ' ' '-'`: Replace spaces with hyphens
# `tr '.' '-'`: Replace period with hyphens

tr -dc '[:alnum:]\r\n.\-/ ' |
  tr -s ' ' | tr '[:upper:]' '[:lower:]' |
  tr ' ' '-' | tr '.' '-'
