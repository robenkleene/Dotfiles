%

# C Format Specifiers

Format specifiers.

- `%c`: Character
- `%d`: Signed integer
- `%e` / `%E` / `%g` / `%G`: Scientific notation of floats
- `%f`: Float values
- `%hi`: Signed integer (short)
- `%hu`: Unsigned Integer (short)
- `%i`: Unsigned integer
- `%l` / `%ld` / `%li`: Long
- `%lf`: Double
- `%Lf`: Long double
- `%lu`: Unsigned int / unsigned long
- `%lli` / `%lld`: Long long
- `%llu`: Unsigned long long
- `%o`: Octal representation
- `%p`: Pointer
- `%s`: String
- `%u`: Unsigned int
- `%x` / `%X`: Hexadecimal representation
- `%n`: Prints nothing
- `%%`: Prints % character

## Examples

### Integer

    printf("INT_MAX = %d\n", INT_MAX);

### Char

    printf("%c", s2[k]);

### String (Character Array)

    char longest[MAXLINE];
    printf("%s", longest);

### Float

    printf("%3d %6.1f\n", cel, cel * (9.0 / 5.0) + 32);

### Unsigned Long

    printf("%lu\n", strtol(s, NULL, 16));

### Unsigned Long Long

    printf("ULLONG_MA = %llu\n", ULLONG_MAX);

## Portable Format Specifiers

- `PRIu64`: Unsigned

### Usage

```
printf("foo is equal to %" PRIu64 "!\n", foo);
```
