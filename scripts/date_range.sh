#!/bin/bash

usage () {
  echo "Usage: daterange [-f forward modifier] [-b backward modifier] [-c length of range]"
}

date_count=0
mod_forward=0
mod_backward=0
while getopts f:b:c:h option
do
  case "$option"
  in
      c)  date_count=$OPTARG
      ;;
      f)  mod_forward=$OPTARG
      ;;
      b)  mod_backward=$OPTARG
      ;;
      h)  usage
          exit 0 
          ;;
      :)  usage # Error for missing value after arguement
          exit 1
          ;;
      \?) usage
          exit 1
          ;;
  esac
done

if [[ $date_count -lt 1 ]]; then
  date_count=1
fi

for i in `seq 1 $date_count`
do
  date_offset=$(($i-1+$mod_forward-$mod_backward))
  if [[ $date_offset -lt 0 ]]; then
    date_offset=${date_offset#-} # Absolute value
  fi
  echo `date -v+"$date_offset"d '+%Y-%m-%d'`
done
