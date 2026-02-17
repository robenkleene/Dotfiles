#!/usr/bin/env bash

set -euo pipefail

while IFS= read -r line || [ "$line" ]; do 
  echo ${line}:1:0
done
