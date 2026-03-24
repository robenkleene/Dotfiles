- `:cs find {querytype} {name}`

Find function callers:

```
:cs find c foo
```

- `c` is shorthand for `callers`

Matches can be automatically added to the quickfix list with:

```
:set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
```

# `cs find` `querytypes`

```
0 or s: Find this C symbol
1 or g: Find this definition
2 or d: Find functions called by this function
3 or c: Find functions calling this function
4 or t: Find this text string
6 or e: Find this egrep pattern
7 or f: Find this file
8 or i: Find files #including this file
9 or a: Find places where this symbol is assigned a value
```

