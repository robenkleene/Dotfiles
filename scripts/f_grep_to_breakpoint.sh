#!/usr/bin/env bash

set -euo pipefail

while IFS= read -r line || [ "$line" ]; do 
  echo "b $line"
done
