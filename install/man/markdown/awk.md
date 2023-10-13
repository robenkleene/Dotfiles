# `awk`

`awk` is for manipulating columns of data.

- `awk -F, '{print $5}'`: Use `,` as a separator and print the fifth column.

## Examples

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
