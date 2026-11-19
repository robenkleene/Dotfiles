#!/usr/bin/env bash

set -euo pipefail

force=""
while getopts ":fh" option; do
  case "$option" in
    f)
      force="-f"
      ;;
    h)
      echo "Usage: command [-hf]"
      exit 0
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

cd "$(dirname "$0")" || exit 1
./cleanup.sh "$force"
./install.sh "$force"

source packages.sh
# `uv tool upgrade` also picks up new commits for tools installed from git,
# even when the version number hasn't changed
if [[ -n "$force" ]]; then
  set -x
  uv tool upgrade --all
  set +x
else
  echo "Upgrading all tools"
fi
