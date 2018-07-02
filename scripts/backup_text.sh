#!/usr/bin/env bash

backup_root_directory=~/Archive/Text/
today=`date +%Y-%B-%d`
backup_directory=$backup_root_directory$today
mkdir -p $backup_directory
archive_file=`mktemp $backup_directory/$today-ArchivedText.XXXX`
cat > $archive_file
destination_archive_file=$archive_file.txt
mv -n $archive_file $destination_archive_file
if [[ -f "$archive_file" ]]; then
  echo -n $archive_file
else
  echo -n $destination_archive_file
fi
