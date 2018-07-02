#!/bin/sh

logs_directory_path=$HOME/Library/Logs/CoreSimulator
cd "$logs_directory_path"
log_path_component=`find . -print0 | xargs -0 -n 100 stat -f"%m %Sm %N" | sort -nr | awk '{$1="";print}' | head -1 | perl -pe 's/.*?\.//'`
echo $logs_directory_path$log_path_component

