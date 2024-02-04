#!/usr/bin/env bash

set -euo pipefail

awk 'NF { $1=$1; print }' | perl -pe 'chomp if eof' 
