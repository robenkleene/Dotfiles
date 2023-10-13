```
  \        prevents interpretation of following special char
  \|       or
  \w       word constituent
  \b       word boundary
  \sc      character with c syntax (e.g. \s- for whitespace char)
  \( \)    start/end of group
  \&lt; \&gt;    start/end of word (faulty rendering: backslash + less-than and backslash + greater-than)
  \_< \_>  start/end of symbol
  \` \'    start/end of buffer/string
  \1       string matched by the first group
  \n       string matched by the nth group
  \{3\}    previous character or group, repeated 3 times
  \{3,\}   previous character or group, repeated 3 or more times
  \{3,6\}  previous character or group, repeated 3 to 6 times
  \=       match succeeds if it is located at point
  \s-   whitespace character        \s/   character quote character
  \sw   word constituent            \s$   paired delimiter
  \s_   symbol constituent          \s'   expression prefix
  \s.   punctuation character       \s<   comment starter
  \s(   open delimiter character    \s>   comment ender
  \s)   close delimiter character   \s!   generic comment delimiter
  \s"   string quote character      \s|   generic string delimiter
  \s\   escape character
  [:digit:]  a digit, same as [0-9]
  [:alpha:]  a letter (an alphabetic character)
  [:alnum:]  a letter or a digit (an alphanumeric character)
  [:upper:]  a letter in uppercase
  [:lower:]  a letter in lowercase
  [:graph:]  a visible character
  [:print:]  a visible character plus the space character
  [:space:]  a whitespace character, as defined by the syntax table, but typically
             [ \t\r\n\v\f ], which includes the newline character
  [:blank:]  a space or tab character
  [:xdigit:] an hexadecimal digit
  [:cntrl:]  a control character
  [:ascii:]  an ascii character
  [:nonascii:]  any non ascii character
```
