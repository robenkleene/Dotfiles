#!/usr/bin/env bash

set -euo pipefail

while IFS= read -r line || [ "$line" ]; do 
  echo ${PWD}/$line
done
