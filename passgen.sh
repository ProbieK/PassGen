#!/bin/bash
#Author: Joshua Kroger
#https://github.com/ProbieK/

#Do help stuff
if [ "$1" == "-h" ]
then
    echo ""
    echo "Usage:"
    echo "$ ./passgen.sh [char count] [charset]"
    echo "Both [char count] and [charset] variables can be left blank. Defaults to \"20\" and \"graph\""
    echo "If you pass a charset variable, you must also pass a char count variable"
    echo ""
    echo "Example:"
    echo "$ ./passgen.sh"
    echo "or"
    echo "$ ./passgen.sh 16"
    echo "or"
    echo "$ ./passgen.sh 16 graph"
    echo ""
    echo "Sample Output:"
    echo "@hA}x8GQtNJ6u_)0"
    echo ""
    echo "Charactor Set Options:"
    echo 'digit		Digits: 0-9'
    echo 'lower		Lower-case letters: a-z'
    echo 'upper		Upper-case letters: A-Z'
    echo 'alpha		Alphabetic characters: lower and upper: A-Za-z'
    echo 'alnum		Alphanumeric characters: alpha and digit: 0-9A-Za-z'
    echo 'punct		Punctuation characters'
    echo 'graph		Graphical characters: alnum and punct'
    echo 'print		Printable characters: alnum, punct, and space'
    echo ''
	exit 0
fi

#Set Default Values
if [ -z "$2" ]; then
    char='graph'
else
    char="$2"
fi
if [ -z "$1" ]; then
    #POSIX compliant min/max character generation
    num=$(awk -v min=10 -v max=20 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')
else
    num="$1"
fi

#Detect OS for later special uses
if [ "$(uname)" == "Darwin" ]; then
    HOSTOS='MACOS'
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    HOSTOS='LINUX'
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    HOSTOS='WIN32'
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    HOSTOS='WIN64'
fi

#The meat and potatos of this password generator
var=$(strings - /dev/urandom | grep -o "[[:"$char":]]" | head -n "$num" | tr -d '\n')
echo "$var"

#Copy password to clipboard on MacOS
if [ $HOSTOS == "MACOS" ]; then
  printf '%s' "$var" | pbcopy
fi

#Copy password to clipboard on Linux hosts with xclip
if [ $HOSTOS == LINUX ]; then
  if command -v xclip > /dev/null; then
    printf '%s' "$var" | xclip -selection c
  else
    echo "If you install xclip, I can copy the password right to your clipboard!"
  fi
fi
