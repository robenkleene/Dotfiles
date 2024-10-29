# `struct` vs `class`

- The only difference between a `struct` and a `class` is that a `struct` is `public` by default, and a class is `private` by default
- `explicit` is used to prevent implicit conversion (e.g., it can be used to prevent an `int foo` from being implicitly converted to an `enum bar`, for example in a `struct` constructor that takes an `enum` as a parameter)
- Slicing also happens if you assign a derived class to a variable declared as a base class.
- To avoid slicing, return a pointer or a reference instead of a value

# Initialization

- Primitive types are not initialized by default in C++, behavior is undefined if they are accessed before assigning a value. This is true both for inline variables and member variables.

# Casting

``` cpp
if (dynamic_cast<foo*>(bar) != NULL) {
  std::cout << "&bar = %p" << &bar << std::endl;
}
```
