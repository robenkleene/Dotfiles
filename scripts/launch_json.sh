#!/usr/bin/env bash

set -euo pipefail

if [[ ! -x "$(command -v jq)" ]]; then
  echo "Error: jq is not executable" >&2
  exit 1
fi

command=$(jq --raw-output '.configurations[0].runtimeExecutable' .vscode/launch.json)
echo "$command"
