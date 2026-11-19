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

python=$(latest_python)
if [[ -z "$python" ]]; then
  echo "Couldn't find the latest Python version" >&2
  exit 1
fi

if ! installed_pythons | grep -q -x -F "$python"; then
  if [[ -n "$force" ]]; then
    set -x
    # `--no-bin` keeps `python3.<minor>` out of `~/.local/bin`, the tools bring
    # their own Python
    uv python install --no-bin "$python"
    set +x
  else
    echo "Installing $python"
  fi
fi

# `--python` moves every tool onto the latest Python, and `uv tool upgrade`
# also picks up new commits for tools installed from git, even when the version
# number hasn't changed
if [[ -n "$force" ]]; then
  set -x
  uv tool upgrade --all --python "$python"
  set +x
else
  echo "Upgrading all tools on $python"
fi

# Only remove the other versions after the tools move off them, removing a
# Python breaks the tools still using it
installed_pythons | while IFS= read -r installed; do
  if [[ "$installed" != "$python" ]]; then
    if [[ -n "$force" ]]; then
      set -x
      uv python uninstall "$installed"
      set +x
    else
      echo "Uninstalling $installed"
    fi
  fi
done
