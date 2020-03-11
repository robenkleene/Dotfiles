#!/usr/bin/env bash

set -e

for file in *.blend; do
  filename="${file%.*}"
  blender --background "${file}" --render-output //"${filename}-" "$@"
done
