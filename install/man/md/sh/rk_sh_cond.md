# Unbound Variables

Safely testing for a unbound variable (this allows `set -u` to be on to fail if an unbound variable is found):

```
if [[ -n "${file_path:-}" ]]; then
```

# Boolean

Bash doesn't support boolean variables natively, a workaround is to just set a variable:

```
foo=1
```

And then use a check for whether that variable is empty:

```
if [[ -n "${foo:-}" ]]; then
```

# Equality

These are equivalent:

    [[ $x == "$y" ]]
    [[ $x = "$y" ]]
    [ "$x" == "$y" ]
    [ "$x" = "$y" ]

# String Comparison

In Bash the right hand side is always a glob.

This compares `$PWD` to a string with wildcards, this isn't comparing files, just strings:

    [[ $PWD/ = $HOME/*/* ]]

This exits `1` in `~` and `/`, but exits `0` in `~/Desktop`.

This appears to be equivalent:

    [[ $PWD = $HOME/* ]]

As does this:

    [[ $PWD =~ $HOME/.* ]]
