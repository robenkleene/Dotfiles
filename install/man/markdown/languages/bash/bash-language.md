%

# Bash Language

- Quoting a variable when using it prevents word splitting:

```
$ foo="one two three"; for bar in $foo; do echo $bar; done
# one
# two
# three
$ foo="one two three"; for bar in "$foo"; do echo $bar; done
# one two three
```

Note that in `zsh` these are both the same because `zsh` does field splitting (this means `echo $foo` always passes in separate arguments, it's the same as `echo one two three`). To get the same behavior as Bash, use `$=foo`:

```
foo="one two three"; for bar in $=foo; do echo $bar; done
# one
# two
# three
```
