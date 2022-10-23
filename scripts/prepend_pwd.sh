#!/usr/bin/env bash

set -euo pipefail

while read i; do
  echo ${PWD}/$i
done
