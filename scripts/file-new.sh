#!/bin/sh

BASENAME="untitled"

if [ ! -z "$1" ]; then
	cd "$1" || {
		echo "Failed to create a new file because the directory is invalid"
		exit 1
	}
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

touch "$FILENAME"
PATH=`pwd`
echo $PATH/$FILENAME