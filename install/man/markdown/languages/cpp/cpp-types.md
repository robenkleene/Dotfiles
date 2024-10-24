- The only difference between a `struct` and a `class` is that a `struct` is `public` by default, and a class is `private` by default
- `explicit` is used to prevent implicit conversion (e.g., it can be used to prevent an `int foo` from being implicitly converted to an `enum bar`, for example in a `struct` constructor that takes an `enum` as a parameter)
- When a function is specified as `virtual` and another function uses `override`, if the `virtual` function returns a base type and the `override` function returns a derived type then the derived type will be "sliced" on return, removing the `derived` information from the base type.
- To avoid slicing, return a pointer or a reference instead of a value