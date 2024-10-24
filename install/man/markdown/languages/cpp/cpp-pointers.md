- A raw pointer is a variable that contains the memory address of an object (or function)
- A `unique_ptr` is a wrapper around a raw pointer that removes the copy and copy assignment constructors to ensure there's only one owner of the managed object
- Prefer references (`Bar& foo`) over pointers (`Bar* foo`) because references can't be null
- A reference (e.g., `Bar& foo` as a function parameter) is just a pointer that can't be null
- `const` means that a pointer can be assigned, e.g., (`const int foo`) can't do `*foo = 42`
- When an variable object is `const` it can only access methods on its class that are also marked `const`

# References

References are just that, references to an existing object, this means for example that you can't have a function returns a reference return a local variable, because that's variable is temporary value that will leave memory at the end of its scope (and a reference can't be null).

# `.` vs. `->`

- `foo.bar`: Access a member variable
- `foo->bar`: Access a member variable on a pointer (shorthand for `(*foo).bar`)

# `*` vs. `&` vs. `unique_ptr`

For a `unique_ptr` member variable:

```
std::unique_ptr<Foo> foo;
```

The constructor takes a reference:

```
foo(&fooIn)
```

The `&` returns the address, so a `unique_ptr` constructor takes a raw pointer.

## `unique_ptr` to Raw Pointer

`get()` is used to access the raw pointer.

If a function takes a pointer as a parameter:

```
void SetFoo(Foo* const bar);
```

To pass in a `unique_ptr`, use `get`:

```
SetFoo(foo->get());
```

# Memory Management

- If you use `new` you need to use `std::destroy` somewhere to prevent a leak.

## Smart Pointers

`std::move` is usually only used with smart pointers, i.e., to transfer ownership (which means the `std::destroy` life-cycle event will happen for the new class and not the old)

``` cpp
std::unique_ptr<int> valuePtr;
valuePtr.reset(new int(47));
```

### Dangers

If you have a `unique_ptr` member variable:

```
std::unique_ptr<Foo> foo;
```

You probably never want to assign that via the constructor (e.g., don't do `foo(fooIn)`) because that will result in a doubly released pointer as both this member variable, and the original owner, will calll `std::destroy` on it.
