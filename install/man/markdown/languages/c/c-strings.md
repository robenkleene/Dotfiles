%

# C Strings

## String Pointers vs. Arrays

C has two ways of storing a string:

- `char*`: A pointer
- `char[]`: An array

These are technically different types, but a `char` array is coerced into a pointer if it's passed as a parameter to a function that takes a `char` pointer.

A `char` pointer can be iterated through with `s++`, as in the following examples to print the string:

``` c
void hash_test(char *s) {
    while (*s != '\0') {
        printf("%c", *s);
        s++;
    }
}
```

A `char*` pointer in C points to a single memory address (like all pointers). E.g.,:

``` c
char *p = "abc";
```

`p` is the memory address and `*p` is `a` (e.g., `printf("%c", *p);` prints `a`).

But in memory, a string literal is actually stored as an array with with a null character (`\0`) as the last element:

    +---+      +-----+-----+-----+------+
    | p | ---> | 'a' | 'b' | 'c' | '\0' |
    +---+      +-----+-----+-----+------+

Some functions in C automatically handle strings, e.g., `printf(p)` will print `abc`. `printf("%s", p);` can also be used to print the entire string.

## Converting `char` to `int`

Characters are `int` which has a couple of implications.

If `c` is a single-character digit, then the expression `c - '0'` will convert that digit to an `int`.

``` c
c - '0'
```

The ASCII value of a digit can be printed by using the `int` (`%i`) format specifier.

``` c
printf("%c = %i\n", *s, *s);
```
