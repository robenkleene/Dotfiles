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

dry_run="--dry-run"
if $force; then
  dry_run=""
else
  echo "Dry Run\n"
fi

if $deploy_local; then
  echo "Got here"
fi

for server in "${servers[@]}"; do
  server_path="$server:$deploy_path"
  # Sync base website
  echo "Syncing robenkleene.com"
  rsync --rsh=ssh --verbose --archive $dry_run --delete \
    --exclude=".DS_Store" \
    --filter 'protect /resume/' \
    ${project_dir}public/ \
    $server_path

  resume_path="${project_dir}vendor/resume/public/"
  # Test if the resume directory is present, if it is, also sync that directory
  if [[ -d "$resume_path" ]]; then
    echo "Syncing robenkleene.com/resume"
    rsync --rsh=ssh --verbose --archive $dry_run --delete \
      --exclude=".DS_Store" \
      $resume_path \
      ${server_path}resume/
  fi
done
