#!/bin/sh

SNIPPETS_DIRECTORY=~/Developer/Snippets

eval SNIPPETS_DIRECTORY_EXPANDED=${SNIPPETS_DIRECTORY}
if [ ! -d "$SNIPPETS_DIRECTORY_EXPANDED" ]; then
    echo "Error: $SNIPPETS_DIRECTORY_EXPANDED is not a directory"
    exit 1
fi

usage () {
    echo "Usage: snpt [-l language] [-o] [-s snippet]"
}

OPEN=false
while getopts l:os:h option
do
    case "$option"
	in
	l)  LANGUAGE=$OPTARG
	    ;;
	s)  SNIPPET=$OPTARG
	    ;;
	o)  OPEN=true
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

if [[ -z "$SNIPPET" && -z "$LANGUAGE" ]]; then
	if ! $OPEN; then
		# Allows no parameter simple calls to work
		SNIPPET=$1
	fi
fi

if [ -z "$SNIPPET" ]; then
    # If no snippet was supplied as an argument, a read one line from stdin
    read SNIPPET
fi

if [[ ! -z "$LANGUAGE" ]]; then
    SNIPPET=$SNIPPET.$LANGUAGE
fi

if [[ "${SNIPPET:0:1}" == "." ]]; then
	# Auto-insert template for the given language if no snippet is provided. Note that right now this clashes with the read from line above
	SNIPPET=Template$SNIPPET
fi


MATCH=$(find $SNIPPETS_DIRECTORY -iname "$SNIPPET" -print -quit)

if [ -z "$MATCH" ]; then
	echo "No snippet found for \"$SNIPPET\""
	exit 1
fi

if $OPEN; then
    open "$MATCH"
else
    cat "$MATCH"
fi
