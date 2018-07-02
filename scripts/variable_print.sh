#!/bin/sh

lua="lua"
ruby="rb"
lisp="el"
javascript="js"
coffeescript="coffee"
objectivec="m"

usage () {
    echo "Usage: variable-print -l language -v variable"
    echo "\nLanguages:"
    echo "$ruby : ruby"
    echo "$lisp : lisp"
    echo "$lua : lua"
    echo "$javascript : JavaScript"
    echo "$coffeescript : CoffeeScript"
    echo "$objectivec : Objective-C"
}

while getopts l:v:h option
do
    case "$option"
	in
	l)  language=$OPTARG
	    ;;
	v)  variable=$OPTARG
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

if [[ -z "$language" ]]; then
    echo "No language specified\n"
    usage
    exit 1
fi

if [ -z "$variable" ]; then
    # If no variable was supplied as an argument, a read one line from stdin
    read variable
fi

if [ -z "$variable" ]; then
	echo "No variable provided"
	usage
	exit 1
fi

if [ "$language" = "$ruby" ]; then
    echo "puts \"$variable = \" + $variable.to_s"
    exit 0
fi

if [ "$language" = "$lisp" ]; then
    echo "(message \"$variable = %s\" $variable)"
    exit 0
fi

if [ "$language" = "$javascript" ]; then
    echo "console.log(\"$variable = \" + $variable);"
    exit 0
fi

if [ "$language" = "$coffeescript" ]; then
    echo "console.log \"$variable = \" + $variable"
    exit 0
fi

if [ "$language" = "$objectivec" ]; then
    echo "NSLog(@\"$variable = %@\", $variable);"
    exit 0
fi

if [ "$language" = "$lua" ]; then
    echo "print(\"$variable = \", $variable)"
    exit 0
fi

echo "Language \"$language\" isn't supported"
usage
exit 1
