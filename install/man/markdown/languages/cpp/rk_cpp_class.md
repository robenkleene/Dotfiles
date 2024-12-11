- Functions marked `static` don't rely on instance-specific member variables or method (i.e., class method vs. instance method)

# Constructors

In this case `foo` will be set to an instance of the class calling the default constructor:

``` cpp
class Foo { }
int main() {
  Foo foo;
}
```

## Base initializers

Constructors can take base initializers:

``` c++
class Foo {
public:
    Foo(int barIn) : bar(barIn) { }
private:
    int bar;
};
```

# Destructors

Including a default destructor ensures that deleting a class through a base class pointer, also calls derived class destructors:

``` c++
  virtual ~Foo() = default;
```

# `virtual` & `override`

- When a function is specified as `virtual` and another function uses `override`, if the `virtual` function returns a base type and the `override` function returns a derived type then the derived type will be "sliced" on return, removing the `derived` information from the base type.

# Lifetimes

## Dangling Pointer

A dangling pointer is when a pointer references an instance of an object that has already been freed.

When a function on a class is called from a dangling pointer, *will actually run*, because the function is resolved statically at compile time, the dangling pointer crash will only happen once a member variable is accessed, because that's what requires accessing the freed memory.

The exception to this is virtual functions, virtual functions have to be determined at runtime, because with a virtual object the type of an object is not known at compile time. So with virtual functions, a pointer to the "V-table" (virtual table) is accessed off of the instance. Since the instance will be a freed object, the crash will happen when running the function in the case of a virtual function (because the pointer state will be accessed to try to get a reference to the V-table).

# Casting

Run-Time Type Information (RTTI) is the name of the C++ feature.

`dynamic_cast`

``` c++
Base* b = new Derived();
Derived* d = dynamic_cast<Derived*>(b);
```
