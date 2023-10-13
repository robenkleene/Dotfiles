%

# Fish Scripting

## Variables

By default, a multi-line variable will be turned into a list. This means, this sequence will print out the output without the new lines (since when a list is printed, it uses spaces instead of new lines):

    set build_output (pbpaste)
    echo $build_output

This will create a single variable with new lines that prints correctly:

    set build_output "$(pbpaste)"

Alternatively, the list can be printed with new lines using `printf`:

    printf "%s\n" $build_output

## String Interpolation

Use `$(<command>)` to make a subshell within a string:

    mkdir "$(today) nvim"

## Quoting

Numeric values don't need to be quoted:

    if test $status -eq 0
        echo -n (basename $git_path)
    end

## Parameter Expansion

Parameter expansion is the act of expanding special characters in parameters, for example globbbing. Parameter expansion does *not* happen in quotes.

    echo *.sh # a_file.sh
    echo "*.sh" # *.sh
