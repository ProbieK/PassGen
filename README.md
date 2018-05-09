# passgen.sh    
### Usage:    
`$ sudo chmod +x ./passgen.sh`    
`$ ./passgen.sh [option] [value]`    
You may call the script without flags and it will generate a password  
between 10 and 20 characters long in the "graph" character set.   

### Example:    
`$ ./passgen.sh`    
or    
`$ ./passgen.sh -n 16`    
or    
`$ ./passgen.sh -n 16 -c graph`    

### Sample Output:    
@hA}x8GQtNJ6u_)0    

### Command Line Options:    
| Command Switch | Effect |
| --- | --- |
| -h or --help | Shows help and exits |
| -n or --number	| Modifies the length of the password |
| -c or --char	| Modifies the character set |
| -m or --mute	| Mutes all optional terminal output |    

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
##### In any terminal window type:    
`passgen`    
