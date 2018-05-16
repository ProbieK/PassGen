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
    echo "Password Length:  16"
    echo "Password Charset: graph"
    echo "@hA}x8GQtNJ6u_)0"
    echo ""
    echo "Command Line Options:"
    echo "-h or --help      Shows this help and exits"
    echo "-n or --number    Modifies the length of the password"
    echo "-c or --char      Modifies the character set"
    echo "-s or --silent    Silences all optional terminal output"
    echo "-m or --min       Sets the minimum length of the password (must be used with --max or unexpected lengths will result)"
    echo "-n or --max       Sets the maximum length of the password"
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
NC='\033[0m'
CYAN='\033[0;36m'
silent='false'
char='graph'
num_min='10'
num_max='20'

function set_min_max {
num=$(awk -v min=$num_min -v max=$num_max 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')
}

#Parse Command Line Options
ARGS=( "$@" )
for i in "${!ARGS[@]}"; do
        case "${ARGS[i]}" in
                '')
                                continue
                        ;;
                -h|--help)
                                show_help
                        ;;
                -n|--number)
                                num="${ARGS[i+1]}"
                                unset 'ARGS[i+1]'
                        ;;
                -c|--char)
                                char="${ARGS[i+1]}"
                                unset 'ARGS[i+1]'
                        ;;
                -s|--silent)
                                silent='true'
                        ;;
                -m|--min)
                                num_min="${ARGS[i+1]}"
                                unset 'ARGS[i+1]'
                        ;;
                -n|--max)
                                num_max="${ARGS[i+1]}"
                                unset 'ARGS[i+1]'
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

#Set min and max length values
set_min_max

#Password Stats
if [ $silent == "false" ]; then
  echo "Password Length:  $num"
  echo "Password Charset: $char"
fi

#The meat and potatos of this password generator
var=$(strings - /dev/urandom | grep -o "[[:"$char":]]" | head -n "$num" | tr -d '\n')
#If the generated password ends in a '\' then the '\' is escaped
if [[ "$var" =~ '\'$ ]]; then
  echo -e "${CYAN}$var\\${NC}"
else
  echo -e "${CYAN}$var${NC}"
fi

#Copy password to clipboard on MacOS
if [ $HOSTOS == "MACOS" ]; then
  printf '%s' "$var" | pbcopy
fi

#Copy password to clipboard on Linux hosts with xclip
if [ $HOSTOS == "LINUX" ]; then
  if command -v xclip > /dev/null; then
    printf '%s' "$var" | xclip -selection c
  else
    if [ $silent == "false" ]; then
      echo "If you install xclip, I can copy the password right to your clipboard!"
    fi
  fi
fi
