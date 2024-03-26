#!/usr/bin/env bash

filename=$(basename "$1")
title=$(echo "$filename" | ~/.bin/f_from_filename_to_title | tr -d '\n')
echo "# $title"
echo
