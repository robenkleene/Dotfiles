# Rust

## `str`, `String`, `&String`, `&str`

- `String` is a string, and owned
- `&String` is an unowned string (a reference to a string)
- `&String` can be coerced to `&str` but not vice-versa (making `&str` an ideal parameter)
- `&str` is a read-only reference to a string slice

## `vec` & Arrays

- `vec` is a growable array
