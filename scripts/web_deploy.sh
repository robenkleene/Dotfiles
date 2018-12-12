#!/usr/bin/env bash

set -e

command_line_args=("$@")
if [[ -f ".web_deploy" ]]; then
  while read -r line; do
    file_args+=("$line")
  done <".web_deploy"
fi

force=false
deploy_local=false
set_args() {
  # Local OPTIND lets `getopts` be called twice
  local OPTIND
  while getopts ":s:d:p:e:lfh" option; do
    case "$option" in
      d)
        deploy_path="$OPTARG"
        deploy_path="${deploy_path#"${deploy_path%%[![:space:]]*}"}"
        deploy_path="${deploy_path%"${deploy_path##*[![:space:]]}"}"
        ;;
      p)
        local_path="$OPTARG"
        local_path="${local_path#"${local_path%%[![:space:]]*}"}"
        local_path="${local_path%"${local_path##*[![:space:]]}"}"
        ;;
      l)
        deploy_local=true
        ;;
      f)
        force=true
        ;;
      e)
        excludes+=("$OPTARG")
        ;;
      s)
        hosts+=("$OPTARG")
        ;;
      h)
        echo "Usage: web_deploy -p <local path> -d <deploy path> [-s <host>] [-lf]"
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
}

# Hoops to jump through to make command line `hosts` overide settings from the
# file
set_args "${file_args[@]}"
old_hosts=("${hosts[@]}")
unset hosts
set_args "${command_line_args[@]}"
if [ ${#hosts[@]} -eq 0 ]; then
  hosts=("${old_hosts[@]}")
fi

if [[ -z "$hosts" && $local_sync = "false" ]]; then
  echo "Missing host with -s option or -l option for local" >&2
  exit 1
fi

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

exclude_flags=""
for exclude in "${excludes[@]}"; do
  exclude="${exclude#"${exclude%%[![:space:]]*}"}"
  exclude="${exclude%"${exclude##*[![:space:]]}"}"
  exclude_flags+="--exclude=\"$exclude\" "
done

if $deploy_local; then
  deploy_path_parent="$(dirname "$deploy_path")"
  if [[ ! -d "$deploy_path_parent" ]]; then
    echo "Skipping local deploy because $deploy_path_parent is not a directory" >&2
  else
    echo "Deploying $local_path to $deploy_path"
    eval "rsync --verbose --archive $dry_run --delete \
      $exclude_flags \
      --filter 'protect /resume/' \
      $local_path \
      $deploy_path"
    echo
  fi
fi

is_host_defined() {
  local host="$1"
  # Hack to determine if a hsot is defined, in the `ssh -G` output, the
  # hostname will match the provided parameter if the host is not defined. If
  # it is defined, the hostname will be the IP address or URL.
  if ! ssh -G "$host" | grep "^hostname ${host}$" >/dev/null; then
    return
  fi
  false
}

for host in "${hosts[@]}"; do
  host="${host#"${host%%[![:space:]]*}"}"
  host="${host%"${host##*[![:space:]]}"}"
  if ! is_host_defined "$host"; then
    # Only deploy to defined hosts, if a host is setup on this machine, the
    # implication is it should be deployed to.
    echo "Skipping $host because it is not configured"
    continue
  fi
  server_path="$host:$deploy_path"
  echo "Deploying $local_path to $server_path"
  eval "rsync --rsh=ssh --update --verbose --archive $dry_run --delete \
    $exclude_flags \
    $local_path \
    $server_path"
  echo
done
