# Compiling

## `clang`

If `-o myprogram` is omitted, it will use `a.out` by default.

```
clang -framework Foundation foo.m -o foo
```

## `gcc`

```
gcc foo.m -framework Foundation -o foo
```
