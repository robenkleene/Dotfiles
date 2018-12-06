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
        deploy_paths+=("$OPTARG")
        ;;
      p)
        local_paths+=("$OPTARG")
        ;;
      l)
        deploy_local=true
        ;;
      f)
        force=true
        ;;
      s)
        servers+=("$OPTARG")
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

if [[ -z "$servers" && ! $local_sync ]]; then
  echo "Missing server with -s option or -l option for local" >&2
  exit 1
fi

# TODO: The count of the `deploy_paths` has to match the count of the
# `local_paths`

${#array[@]}

if [[ -z "$deploy_paths" ]]; then
  echo "Missing deploy paths with -d option" >&2
  exit 1
fi

if [[ -z "$local_paths" ]]; then
  echo "Missing local paths with -l option" >&2
  exit 1
fi

if [[ ${#local_paths[@]} != ${#deploy_paths[@]} ]]; then
  echo "Number of local paths ${#local_paths[@]} doesn't match deploy paths ${#deploy_paths[@]}" >&2
  exit 1
fi

for local_path in "${local_paths[@]}"; do
  if [[ ! -d "$local_path" ]]; then
    echo "$local_path is not a directory" >&2
    exit 1
  fi
done

dry_run="--dry-run"
if $force; then
  dry_run=""
else
  echo "Dry Run"
  echo
fi

if $deploy_local; then
  echo "Got here"
fi

for server in "${servers[@]}"; do
  for i in "${!local_paths[@]}"; do
    local_path=${local_paths[$i]}
    deploy_path=${deploy_paths[$i]}
    server_path="$server:$deploy_path"
    # Ugh, I've got write out a protect statement for every "deploy_path"
    # except this one
    echo "Deploying $local_path to $deploy_path"
    rsync --rsh=ssh --verbose --archive $dry_run --delete \
      --exclude=".DS_Store" \
      --filter 'protect /resume/' \
      ${project_dir}public/ \
      $server_path
    echo
  done
done
