#!/usr/bin/env bash

current=$(tmux display-message -p '#I')
target=$1
count=$(($1-$current))

parameter=':+1'
if [ $count -lt 0 ]; then
  parameter=':-1'
  count=$((-$count))
fi
count=$(($count-1))

for i in `seq 0 $count`; do
  tmux swap-window -t $parameter
done
