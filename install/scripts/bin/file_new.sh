#!/usr/bin/env bash

# The AppleScript to create a new file from Finder depends on this script

set -euo pipefail

path_only="false"
image="false"
root=""
while getopts ":ipr:h" option; do
  case "$option" in
    p)
      path_only="true"
      ;;
    r)
      root="$OPTARG"
      ;;
    i)
      image="true"
      ;;
    h)
      echo "Usage: command [-hf] [-p <file_path>]"
      exit 0
      ;;
    :)
      echo "Option -OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -OPTARG" >&2
      exit 1
      ;;
  esac
done

if [[ -n "$root" ]]; then
   cd "$root" || {
           echo "Failed to create a new file because the directory is invalid"
           exit 1
   }
fi

BASENAME="untitled"
if [[ "$image" == "true" ]]; then
  BASENAME=$BASENAME.png
fi

for i in {1..9}
do
	if [[ $i -eq 1 ]]; then
		FILENAME="$BASENAME"
	else
		FILENAME="$BASENAME $i"		
	fi

	if [[ ! -f $FILENAME ]]; then
		break
	fi
	FILENAME=""
done

if [ -z "$FILENAME" ]; then
	echo "Failed to create a new file because there are two many $BASENAME files"
	exit 1
fi

if [[ "$path_only" != "true" ]]; then
  touch "$FILENAME"
fi
PATH=`pwd`
echo $PATH/$FILENAME
