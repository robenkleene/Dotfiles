%

# Bitwise Operators

- `&`: AND, used to mask off some set of bits, e.g., `n & 0177` masks off all but the lower-order 7 bits of `n` because `0177` (which is in octal) is 127 in base-10, which is seven ones in the lower-order bits in binary.
- `|`: OR
- `^`: Exclusive OR
- `<<`: Left shift, e.g., `0b100 << 2 = 0b10000`
- `>>`: Right shift, e.g., `0b100 >> 2 = 0b1`
- `~`: One's complement (unary operator), inverts all `1` and `0`. E.g., `~00001 = 11110`

## Two's Complement

In two's complement, positive numbers are standard binary:

- `0000`: `0`
- `0001`: `1`
- `0010`: `2`

And negative numbers swap the roles of `0` and `1` and start from `-1` at `1111`, so:

- `1111`: `-1`
- `1110`: `-2`
- `1101`: `-3`

## Useful Operations

- `0`: All zeros (of course).
- `~0`: All ones.
- `~0 << n`: All ones except the right-most `n` bits.
- `~(~0 << n)`: All zeros except the right-most `n` bits.
- `0b10101010101010101010101010101010`: The easiest way to write a number with alternating ones and zeros.

### Tips

- Using `~0 << n` or `~(~0 << n)` as bit fields are an easy way to capture to right- or left-most bits.
- Use `~0 << n` and `~(~0 << n)`, then an `|`, to get the left- *and* right- most bits.

## Printing

Functions for printing bits, it can be added to a header (`printbits.h`) and imported (`#include "printbits.h"`):

``` c
#include <stdio.h>

void printbits(size_t const size, void const *const ptr) {
    unsigned char *b = (unsigned char *)ptr;
    unsigned char byte;
    int i, j;

    for (i = size - 1; i >= 0; i--) {
        for (j = 7; j >= 0; j--) {
            byte = (b[i] >> j) & 1;
            printf("%u", byte);
        }
    }
    puts("");
}

void qpb(int x) {
    printbits(sizeof(x), &x);
}
```
