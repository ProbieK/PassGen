# passgen.sh    
### Usage:    
`$ sudo chmod +x ./passgen.sh`    
`$ ./passgen.sh [option] [value]`    
You may call the script without flags and it will generate a password  
between 16 and 24 characters long in the "graph" character set.   

### Example:    
`$ ./passgen.sh`    
or    
`$ ./passgen.sh -n 16`    
or    
`$ ./passgen.sh -n 16 -c graph`    

### Sample Output:    
Password Length:  16  
Password Charset: graph  
@hA}x8GQtNJ6u_)0    

### Command Line Options:    
| Command Switch | Effect |
| --- | --- |
| -h or --help | Shows help and exits |
| -n or --number	| Modifies the length of the password |
| -c or --char	| Modifies the character set |
| -s or --silent	| Silences all optional terminal output |    
| -m or --min	| Sets the minimum length of the password (must be used with --max or unexpected lengths will result) |
| -x or --max	| Sets the maximum length of the password |
| -g or --grep | Uses grep as the engine to select random characters |
| -p or --perl | Uses perl as the engine to select random characters (default engine) |

### Charactor Set Options:    
| Variable | Charset |
| --- | --- |
| digit | Digits: 0-9 |
| lower	| Lower-case letters: a-z |
| upper	| Upper-case letters: A-Z |
| alpha	| Alphabetic characters: lower and upper: A-Za-z |
| alnum	| Alphanumeric characters: alpha and digit: 0-9A-Za-z |
| punct	| Punctuation characters |
| graph	| Graphical characters: alnum and punct |
| print	| Printable characters: alnum, punct, and space |    

### Recommendation:    
Add an entry in your .bashrc file to alias this command so that it can be run from anywhere.    
`alias passgen="/path/to/script/passgen.sh"`   
Or, if you want to use the output in another script:  
`myvar=$(/path/to/script/passgen.sh -s)`
##### In any terminal window type:    
`passgen`    
