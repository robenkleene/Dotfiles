%

# C Hash

[This hash implementation]() is from chapter 6.6, "Table Lookup" from the *C Programming Language*.

## Hashing Function

> The hashing function, which is used by both lookup and install, adds each character value in the string to a scrambled combination of the previous ones and returns the remainder modulo the array size. This is not the best possible hash function, but it is short and effective.

``` c
unsigned hash(char *s)
{
    unsigned hashval;
    for (hashval = 0; *s != '\0'; s++)
      hashval = *s + 31 * hashval;
    return hashval % HASHSIZE;
}
```

This function takes a `char` pointer, and returns an `unsigned` to use as an array index. The basic premise of the function is to take the sum of each letter in the string multiplied by a prime number.

- `*s + 31 * hashval`: Multiplying by a prime number to reduce the chance of a collusion. Prime numbers are used in hash algorithms because they have the best chance of being unique when multiplied by another number. The `HASHSIZE` is set to a prime number (`#define HASHSIZE 101`) for the same reason. (It's unclear why `31` and not another prime number value is used.)
- `hashval % HASHSIZE`: This is just to get the result in the range `0` to `HASHSIZE`.
