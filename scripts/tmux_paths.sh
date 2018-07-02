#!/usr/bin/env bash

usage () {
  echo "Usage: tmux-paths [-0]"
}

null_terminate=false
while getopts 0h option
do case "$option" in
  0)  null_terminate=true
    ;;
  h)  usage
    exit 0 
    ;;
  :)  usage
    exit 1
    ;;
  \?) usage
    exit 1
    ;;
esac
done

tmp_file=$(mktemp "${TMPDIR:-/tmp}/tmux-paths.XXXX")

if [ ! -f $tmp_file ]; then
  echo "Failed to create a temp file."
  exit 1
fi

for i in $(tmux list-windows | cut -c 1); do
  for j in $(tmux list-panes -t $i | cut -d ' ' -f 7); do
    tmux run-shell -t $j "tmux display -p '#{pane_current_path}' >> $tmp_file"
  done
done
# Note that the front program can change the `pwd`, which might result in paths
# appearing to be missing.
cmd="cat $tmp_file | sort --unique | grep ."
if $null_terminate; then
  cmd="$cmd | tr \"\n\" \"\0\""
fi
eval $cmd
rm $tmp_file
