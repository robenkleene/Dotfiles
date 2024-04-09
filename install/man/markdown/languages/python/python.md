- `\\`: Integer division

# Naming Conventions

- Method names are `snake_case`.
- Variable names are `snake_case`.
- Preceding a method name with an underscore is a convention for indicating it's intended to be a private method (although it's not actually enforced).

# Print

`print("arr =", arr)` automatically inserts a separator, to disable this behavior, use the `sep` parameter:

    print("arr =", arr, sep="")

# Arrays

- Specify an array slice with `1:2`, e.g., `arr[1:2]` or `arr[:5]` or `arr[5:`.
