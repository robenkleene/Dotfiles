#!/usr/bin/env bash

journal_directory=~/Dropbox/Text/Journal
filename=$(ls "$journal_directory" | tail -n 1 | tr -d '\n')
echo "$journal_directory/$filename"
