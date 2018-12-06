#!/bin/sh

set -e

args=("$@")
if [[ -f ".web_deploy" ]]; then
  while read -r line || [[ -n "$line" ]]; do
    args+=("$line")
  done <".web_deploy"
fi

force=false
set_args() {
  while getopts ":s:l:fh" option; do
    case "$option" in
      l)
        local_path="$OPTARG"
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

dry_run="--dry-run"
if $force; then
  dry_run=""
else
  echo "Dry Run\n"
fi

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
project_dir="$script_dir/../"
destination_path="/var/www/html/robenkleene.com/"

if $local_sync; then
  
fi

for server in "${servers[@]}"; do
  server_path="$server:"
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
