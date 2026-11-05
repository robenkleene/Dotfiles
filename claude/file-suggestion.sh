#!/bin/bash
# Supplies `@` file autocomplete like shell tab completion: lists one directory
# level matching the typed prefix, without recursing or consulting git.

query=$(jq -r '.query')
tilde=""
if [[ $query == "~"* ]]; then
  tilde=1
  query="$HOME${query#\~}"
fi
if [[ $query == */* ]]; then
  dir="${query%/*}/"
  base="${query##*/}"
else
  dir=""
  base="$query"
fi

shopt -s nullglob dotglob
for path in "${dir}${base}"*; do
  [[ -d $path ]] && path="$path/"
  [[ $tilde ]] && path="~${path#"$HOME"}"
  printf '%s\n' "$path"
done | head -15
