#!/usr/bin/env bash

usage () {
  echo "Usage: tmux-paths [-0]"
}

null_terminate=false
unique=false
flat=false
all=false
while getopts 0afuh option
do case "$option" in
  a)  all=true
    ;;
  f)  flat=true
    ;;
  u)  unique=true
    ;;
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

if $all; then
  old_IFS=$IFS
  IFS=$'\n'
  for session_info in $(tmux list-sessions -F "#{session_id}:#{session_name}"); do
    old_IFS=$IFS
    IFS=":"
    set $session_info
    session_id=$1
    session_name=$2
    IFS=${old_IFS}
    echo "$session_name" >> $tmp_file
    for window in $(tmux list-windows -t="$session_id" | cut -c 1); do
      for pane in $(tmux list-panes -s -t="$session_id" | cut -d ' ' -f 7); do
        tmux run-shell -t $pane "tmux display-message -p '#{pane_current_path}' >> $tmp_file"
      done
    done
  done
  IFS=${old_IFS}
else
  for i in $(tmux list-windows | cut -c 1); do
    for j in $(tmux list-panes -t $i | cut -d ' ' -f 7); do
      tmux run-shell -t $j "tmux display -p '#{pane_current_path}' >> $tmp_file"
    done
  done
fi


# Note that the front program can change the `pwd`, which might result in paths
# appearing to be missing.
cmd="cat $tmp_file"
if $unique; then
  cmd="$cmd | sort --unique | grep ."
fi
if $null_terminate; then
  cmd="$cmd | tr \"\n\" \"\0\""
fi
eval $cmd
rm $tmp_file
