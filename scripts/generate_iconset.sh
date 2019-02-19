#!/usr/bin/env bash

set -e

dir="Icon.iconset" 
if [[ ! -d $dir ]]; then
  mkdir $dir
else
  echo "A directory already exists at $dir" >&2
  exit 1
fi

file16="icon-16.png"
if [[ -f $file16 ]]; then
  cp "$file16" "$dir/icon_16x16.png"
fi

file32="icon-32.png"
if [[ -f $file32 ]]; then
  cp "$file32" "$dir/icon_32x32.png"
  cp "$file32" "$dir/icon_16x16@2x.png"
fi

file64="icon-64.png"
if [[ -f $file64 ]]; then
  cp "$file64" "$dir/icon_64x64.png"
  cp "$file64" "$dir/icon_32x32@2x.png"
fi

file128="icon-128.png"
if [[ -f $file128 ]]; then
  cp "$file128" "$dir/icon_128x128.png"
  cp "$file128" "$dir/icon_64x64@2x.png"
fi

file256="icon-256.png"
if [[ -f $file256 ]]; then
  cp "$file256" "$dir/icon_256x256.png"
  cp "$file256" "$dir/icon_128x128@2x.png"
fi

file512="icon-512.png"
if [[ -f $file512 ]]; then
  cp "$file512" "$dir/icon_512x512.png"
  cp "$file512" "$dir/icon_256x256@2x.png"
fi

file2014="icon-2014.png"
if [[ -f $file2014 ]]; then
  cp "$file2014" "$dir/icon_512x512@2x.png"
fi
