#!/bin/bash

usage () {
  echo "Usage: daterange [-f forward modifier] [-b backward modifier] [-c length of range]"
}

DATECOUNT=0
FORWARDMODIFIER=0
BACKWARDMODIFIER=0
while getopts f:b:c:h option
do
	case "$option"
	in
	    c)  DATECOUNT=$OPTARG
			;;
	    f)  FORWARDMODIFIER=$OPTARG
			;;
	    b)  BACKWARDMODIFIER=$OPTARG
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

if [[ $DATECOUNT -lt 1 ]]; then
	DATECOUNT=1
fi

for i in `seq 1 $DATECOUNT`
do
	DATEOFFSET=$(($i-1+$FORWARDMODIFIER-$BACKWARDMODIFIER))
	if [[ $DATEOFFSET -lt 0 ]]; then
		DATEOFFSET=${DATEOFFSET#-} # Absolute value
		echo `date -v-"$DATEOFFSET"d '+%m/%d/%Y'`
	else
		echo `date -v+"$DATEOFFSET"d '+%m/%d/%Y'`

	fi	
done