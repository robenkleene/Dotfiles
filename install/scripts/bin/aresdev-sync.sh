#!/usr/bin/env bash

set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

if ! [ -d ".git" ]; then
  echo "Not in a git repository" >&2
  exit 1
fi

if [[ ! $PWD = $HOME/* ]]; then
  echo "Only use in a subdirectory of home" >&2
  exit 1
fi

local_path=$(pwd -P)/;
# Remove home
local_subpath=${local_path#"$HOME"}

force="false"
pull="false"
while getopts ":ufh" option; do
  case "$option" in
    u)
      pull="true"
      ;;
    f)
      force="true"
      ;;
    h)
      echo "Usage: command [-hf] [-p <file_path>]"
      exit 0
      ;;
    :)
      echo "Option -OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -OPTARG" >&2
      exit 1
      ;;
  esac
done

dry_run="--dry-run"
if $force; then
  dry_run=""
else
  echo "Dry Run"
  echo
fi

is_host_defined() {
  local host="$1"
  # Hack to determine if a host is defined, in the `ssh -G` output, the
  # hostname will match the provided parameter if the host is not defined. If
  # it is defined, the hostname will be the IP address or URL.
  if ! ssh -G "$host" | grep "^hostname ${host}$" >/dev/null; then
    return
  fi
  false
}

host=aresdev
if ! is_host_defined "$host"; then
  # Only deploy to defined hosts, if a host is setup on this machine, the
  # implication is it should be deployed to.
  echo "Skipping $host because it is not configured"
  exit 1
fi

# excludes_file=$(mktemp "${TMPDIR:-/tmp}/rsync-excludes.XXXX")
# git ls-files --exclude-standard -oi --directory > "$excludes_file"

includes_file=$(mktemp "${TMPDIR:-/tmp}/rsync-includes.XXXX")
git ls-files -m -o --exclude-standard > "$includes_file"
server_path="${host}:/home/robenkleene$local_subpath"

if ssh ${host} "[ ! -d /home/robenkleene${local_subpath} ]"; then
  echo "Error: ${server_path} does not exist" >&2
  exit 1
fi

# Never add --delete because that will delete ignored files
if [[ "$pull" == "true" ]]; then
  # eval "rsync -c --omit-dir-times --exclude=\".*\" --exclude=\"node_modules\" --exclude-from=$excludes_file --verbose --archive $dry_run \
  eval "rsync -c --omit-dir-times --files-from=$includes_file --verbose --archive $dry_run \
\"$server_path\" \
\"$local_path\""
else
  # eval "rsync -c --omit-dir-times --exclude=\".*\" --exclude=\"node_modules\" --exclude-from=$excludes_file --verbose --archive $dry_run \
  eval "rsync -c --omit-dir-times --files-from=$includes_file --verbose --archive $dry_run \
\"$local_path\" \
\"$server_path\""
fi
rm "$includes_file"
