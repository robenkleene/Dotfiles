#!/usr/bin/env bash

test_log="test.log"
build_log="build.log"
current_log=$build_log
found=false

if [ -f "$test_log" ]; then
  rm "$test_log"
elif [ -d "$test_log" ]; then
  echo "Error $test_log is a directory"
  exit 1
fi

if [ -f "$build_log" ]; then
  rm "$build_log"
elif [ -d "$build_log" ]; then
  echo "Error $build_log is a directory"
  exit 1
fi

IFS='' # Prevent `read line` from stripping white space
while read line; do
  if [[ $found == false && $line =~ "Test Suite" ]]; then 
    current_log=$test_log
    found=true
  fi
  echo $line >> $current_log
  echo $line
done
