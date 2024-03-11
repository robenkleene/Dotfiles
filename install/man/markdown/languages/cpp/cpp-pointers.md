# `cpp` Pointers

A reference (e.g., `Bar& foo` as a function parameter) is just a pointer that can't be null.

- `const` means that a pointer can be assigned, e.g., (`const int foo`) can't do `*foo = 42`
- When an variable object is `const` it can only access methods on its class that are also marked `const`

## Memory Management

- If you use `new` you need to use `std::destroy` somewhere to prevent a leak.

### Smart Pointers

`std::move` is usually only used with smart pointers, i.e., to transfer ownership (which means the `std::destroy` life-cycle event will happen for the new class and not the old)

``` cpp
std::unique_ptr<int> valuePtr;
valuePtr.reset(new int(47));
```
