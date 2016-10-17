# passgen.sh    
### Usage:    
$ ./passgen.sh [char count] [charset]    
Both [char count] and [charset] variables can be left blank. Defaults to "20" and "graph"    
If you pass a charset variable, you must also pass a char count variable    
    
### Example:    
$ ./passgen.sh    
or    
$ ./passgen.sh 16    
or    
$ ./passgen.sh 16 graph    
    
### Sample Output:    
@hA}x8GQtNJ6u_)0    

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
    
