#!/usr/bin/env bash

set -euo pipefail

sed 's/^[[:space:]]*//; s/[[:space:]]*$//' | perl -pe 'chomp if eof' 
