# `str`, `String`, `&String`, `&str`

- `String` is a string, and owned
- `&String` is an unowned string (a reference to a string)
- `&String` can be coerced to `&str` but not vice-versa (making `&str` an ideal parameter)
- `&str` is a read-only reference to a string slice

# Macros

- The exclamation point (`!`) after a symbol means it's a macro, e.g., `println!` is a macro (and `println` won't compile)

# `vec` & Arrays

- `vec` is a growable array
