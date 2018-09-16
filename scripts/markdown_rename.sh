#!/bin/sh

for I in "$@"
do
	OLD_FILE=$I
	OLD_FILENAME=$(basename "$OLD_FILE")
	DIRECTORY=$(dirname "$OLD_FILE")

	NEW_FILENAME=$(~/.bin/markdown_filename "$OLD_FILE")
	if [[ $? == "0" ]]; then
		case $OLD_FILENAME in
		*.* )  
			EXTENSION="${OLD_FILENAME##*.}"
			;;
		* )  
			EXTENSION="md"
			;;
		esac
		NEW_FILENAME=$NEW_FILENAME.$EXTENSION
		NEW_FILE=$DIRECTORY/$NEW_FILENAME
				
	 	if [[ ! -f $NEW_FILE ]]; then
			mv "$OLD_FILE" "$NEW_FILE"
			echo $NEW_FILE
		else
			echo "Error: $NEW_FILE already exists"
			exit 1
	 	fi
	fi
done
