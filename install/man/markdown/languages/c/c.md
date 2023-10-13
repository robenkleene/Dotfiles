%

# C

- `cc hello.c`: Compile to `a.out`
- Always give arrays a length in C, just setting a `0` length array, and then setting an index `array[0] = 10`, and then retrieving that value later, it will be garbage.
- `NULL` checks like `if (ptr)` / `if (!ptr)` are a good practice.

## Stack & Heap

- **Stack**: Local variables
- **Heap**: Pointers created with `malloc`

## Memory Management

- Stack variables are automatically freed when they go out of scope.
- Heap variables have to be manually released with `free(p);`
