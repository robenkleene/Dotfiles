#!/usr/bin/env bash

set -e

perl -pe 's/\%(\w\w)/chr hex $1/ge'
