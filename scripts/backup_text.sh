#!/usr/bin/env bash

message="false"
while getopts ":mh" option; do
  case "$option" in
    m)
      message="true"
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

backup_root_directory=~/Dropbox/Archive/Text/
today=$(date +%Y-%B-%d)
backup_directory=$backup_root_directory$today
mkdir -p "$backup_directory"
archive_file=$(mktemp "$backup_directory/$today-ArchivedText.XXXX")
cat > "$archive_file"
# Add a new line to the end of the file if it's missing, without this `wc` will
# say `0` lines for `1` line.
sed -i '' -e '$a\' "$archive_file"
destination_archive_file=$archive_file.txt
mv -n "$archive_file" "$destination_archive_file"
if [[ -f "$archive_file" ]]; then
  destination_archive_file=$archive_file
fi
if [[ "$message" == "true" ]]; then
  line_count=$(wc -l < "$destination_archive_file" | tr -d " " | tr -d "\n")
  echo -n "Backed up $line_count lines"
else
  echo -n "$destination_archive_file"
fi
