`awk` is for manipulating columns of data.

- `awk -F, '{print $5}'`: Use `,` as a separator and print the fifth column.

# Examples

## Learning

- `$0`: Represents input (i.e., each line)

`awk '/<regex>/'` is short hand for `awk '$0 ~ /<regex>/{print $0}'`.

E.g.:

```
$ echo -n "foo\nbar" | awk '/foo/'
foo
```

`'1'` (i.e., non-zero means "true") is the idiomatic way to print input.

E.g.:

```
$ printf 'gate\napple\nwhat\nkite\n' | awk '1'
gate
apple
what
kite
```

## Capturing Between Delimiters

Capture everything between the first `DUMPSTART` and `DUMPEND` pair:

```
awk '/DUMPSTART.*$/,/^.*DUMPEND.*$/{print; if(/DUMPEND.*$/) exit}'
```

### Only if key is found

```
#!/usr/bin/awk -f

/SECTIONSTART/ {
    in_block = 1;
    block = ""
}
/SECTIONSTART/,/SECTIONEND/ {
    if (in_block) {
        block = block $0 "\n";
    }
    if (/SECTIONKEY/) {
        found_key = 1;
    }
}
/SECTIONEND/ {
    if (in_block) {
        if (found_key) {
            printf "%s", block;
        }
        in_block = 0;
        found_key = 0;
    }
}
```

## Printing Different Number of Surrounding Lines

```
awk '/"title":/{print} /"GlossDef"/{print; for(i=0;i<4;i++) {getline; print}}'
```
