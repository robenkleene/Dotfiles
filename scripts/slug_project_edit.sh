#!/usr/bin/env bash

file=$(~/.bin/slug_project "$1")
$EDITOR "$file"
