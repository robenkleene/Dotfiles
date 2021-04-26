#!/usr/bin/env bash

set -euo pipefail

local_path=$(pwd -P);

force="false"
while getopts ":p:fh" option; do
  case "$option" in
    p)
      file_path="$OPTARG"
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

server_path="$host:$local_path"
eval "rsync --omit-dir-times --verbose --archive $dry_run --delete \
  $local_path \
  $server_path"
