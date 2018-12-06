#!/bin/sh

set -e

args=("$@")
if [[ -f ".web_deploy" ]]; then
  while read -r line || [[ -n "$line" ]]; do
    args+=("$line")
  done <".web_deploy"
fi

force=false
deploy_local=false
set_args() {
  while getopts ":s:d:p:lfh" option; do
    case "$option" in
      d)
        deploy_path="$OPTARG"
        ;;
      p)
        local_path="$OPTARG"
        ;;
      l)
        deploy_local=true
        ;;
      f)
        force=true
        ;;
      s)
        hosts+=("$OPTARG")
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
}

set_args "${args[@]}"

if [[ -z "$hosts" && ! $local_sync ]]; then
  echo "Missing host with -s option or -l option for local" >&2
  exit 1
fi

# TODO: The count of the `deploy_path` has to match the count of the
# `local_path`

${#array[@]}

if [[ -z "$deploy_path" ]]; then
  echo "Missing deploy path with -d option" >&2
  exit 1
fi

if [[ -z "$local_path" ]]; then
  echo "Missing local path with -l option" >&2
  exit 1
fi

if [[ ! -d "$local_path" ]]; then
  echo "$local_path is not a directory" >&2
  exit 1
fi

dry_run="--dry-run"
if $force; then
  dry_run=""
else
  echo "Dry Run"
  echo
fi

if $deploy_local; then
  if [[ ! -d "$deploy_path" ]]; then
    echo "$deploy_path is not a directory" >&2
    exit 1
  fi
  # TODO: Write local deploy
fi

is_host_defined() {
  local host=$1
  # Hack to determine if a hsot is defined, in the `ssh -G` output, the
  # hostname will match the provided parameter if the host is not defined. If
  # it is defined, the hostname will be the IP address or URL.
  if ! ssh -G $host G "^hostname ${host}$" >/dev/null; then
    return
  fi
  false
}

for host in "${hosts[@]}"; do
  if ! is_host_defined $host; then
    # Only deploy to defined hosts, if a host is setup on this machine, the
    # implication is it should be deployed to.
    continue
  fi
  server_path="$host:$deploy_path"
  echo "Deploying $local_path to $deploy_path"
  # rsync --rsh=ssh --verbose --archive $dry_run --delete \
  #   --exclude=".DS_Store" \
  #   --filter 'protect /resume/' \
  #   ${project_dir}public/ \
  #   $server_path
done
