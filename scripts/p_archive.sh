#!/usr/bin/env bash

message="false"
verbose="false"
echo="false"
while getopts ":vmeh" option; do
  case "$option" in
    m)
      message="true"
      ;;
    v)
      verbose="true"
      ;;
    e)
      echo="true"
      ;;
    h)
      echo "Usage: command [-hm]"
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

backup_root_directory=~/Archive/Text/
today=$(date +%Y-%B-%d)
backup_directory=$backup_root_directory$today
mkdir -p "$backup_directory"
archive_file=$(mktemp "$backup_directory/$today-ArchivedText.XXXX")

if [[ "$echo" == "true" ]]; then
  tee "$archive_file"
else
  cat > "$archive_file"
fi

# Add a new line to the end of the file if it's missing, without this `wc` will
# say `0` lines for `1` line.
if sed --version >/dev/null 2>&1; then
  sed -i -e '$a\' "$archive_file"
else
  sed -i '' -e '$a\' "$archive_file"
fi

destination_archive_file=$archive_file.txt
mv -n "$archive_file" "$destination_archive_file"
if [[ -f "$archive_file" ]]; then
  destination_archive_file=$archive_file
fi

if [[ "$verbose" == "false" ]]; then
  exit 0
fi

if [[ "$message" == "true" ]]; then
  line_count=$(wc -l < "$destination_archive_file" | tr -d " " | tr -d "\n")
  echo -n "Backed up $line_count lines"
else
  # if [[ -t 1 ]]; then
  #   # Only echo file path if stdout is a terminal
  echo -n "$destination_archive_file"
  # fi
fi
