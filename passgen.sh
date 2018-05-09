#!/bin/bash
#Author: Joshua Kroger
#https://github.com/ProbieK/

#Do help stuff
function show_help {
    echo ""
    echo "Usage:"
    echo "$ ./passgen.sh [option] [value]"
    echo "You may call the script without flags and it will generate a password"
    echo "between 10 and 20 characters long in the \"graph\" character set."
    echo ""
    echo "Example:"
    echo "$ ./passgen.sh"
    echo "or"
    echo "$ ./passgen.sh -n 16"
    echo "or"
    echo "$ ./passgen.sh -n 16 -c graph"
    echo ""
    echo "Sample Output:"
    echo "@hA}x8GQtNJ6u_)0"
    echo ""
    echo "Command Line Options:"
    echo "-h or --help		Shows this help and exits"
    echo "-n or --number		Modifies the length of the password"
    echo "-c or --char		Modifies the character set"
    echo "-m or --mute		Mutes all optional terminal output"
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
}

#Set Default Values
mute='false'
char='graph'
num=$(awk -v min=10 -v max=20 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')

#Parse Command Line Options
ARGS=( "$@" )
for i in "${!ARGS[@]}"; do
        case "${ARGS[i]}" in
                '')
                                continue
                        ;;
                -h|--help)     show_help
                        ;;
                -n|--number)
                                num="${ARGS[i+1]}"
                                unset 'ARGS[i+1]'
                        ;;
                -c|--char)
                                char="${ARGS[i+1]}"
                                unset 'ARGS[i+1]'
                        ;;
                -m|--mute)      mute='true'
                        ;;
                --)
                                unset 'ARGS[i]'
                                break
                        ;;
                *)
                                continue
                        ;;
        esac
        unset 'ARGS[i]'
done

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

#Error Checking
charsets=( digit lower upper alpha alnum punct graph print )
if [[ ! " ${charsets[@]} " =~ " $char " ]]; then
  echo "Charset not recognized! Aborting!"
  exit 1
fi

#Password Stats
if [ $mute == "false" ]; then
  echo "Password Length:  $num"
  echo "Password Charset: $char"
  echo ""
fi

#The meat and potatos of this password generator
var=$(strings - /dev/urandom | grep -o "[[:"$char":]]" | head -n "$num" | tr -d '\n')
echo "$var"

#Copy password to clipboard on MacOS
if [ $HOSTOS == "MACOS" ]; then
  printf '%s' "$var" | pbcopy
fi

#Copy password to clipboard on Linux hosts with xclip
if [ $HOSTOS == "LINUX" ]; then
  if command -v xclip > /dev/null; then
    printf '%s' "$var" | xclip -selection c
  else
    if [ $mute == "false" ]; then
      echo "If you install xclip, I can copy the password right to your clipboard!"
    fi
  fi
fi
