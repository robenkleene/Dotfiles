#!/usr/bin/env bash

set -euo pipefail

if [[ ! -x "$(command -v jq)" ]]; then
  echo "Error: jq is not executable" >&2
  exit 1
fi

if [[ ! -f ".vscode/launch.json" ]]; then
  echo "Error: .vscode/launch.json does not exist" >&2
  exit 1
fi

command=$(jq --raw-output '.configurations[0].runtimeExecutable' .vscode/launch.json)
args=$(jq --raw-output '.configurations[0].runtimeArgs | join(" ")' .vscode/launch.json)
exec $command $args
