# Bash Equality

These are equivalent:

    [[ $x == "$y" ]]
    [[ $x = "$y" ]]
    [ "$x" == "$y" ]
    [ "$x" = "$y" ]

## String Comparison

In Bash the right hand side is always a glob.

This compares `$PWD` to a string with wildcards, this isn't comparing files, just strings:

    [[ $PWD/ = $HOME/*/* ]]

This exits `1` in `~` and `/`, but exits `0` in `~/Desktop`.

This appears to be equivalent:

    [[ $PWD = $HOME/* ]]

As does this:

    [[ $PWD =~ $HOME/.* ]]
