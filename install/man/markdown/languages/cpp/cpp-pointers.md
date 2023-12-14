# `cpp` Pointers

A reference (e.g., `Bar& foo` as a function parameter) is just a pointer that can't be null.

- `const` means that a pointer can be assigned, e.g., (`const int foo`) can't do `*foo = 42`
- When an variable object is `const` it can only access methods on its class that are also marked `const`
