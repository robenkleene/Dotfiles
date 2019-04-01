#!/usr/bin/env bash

journal_directory="$1"
filename=$(find -s "$journal_directory" -name '[[:digit:]]*' | tail -n 1 | tr -d '\n')
echo "$filename"
