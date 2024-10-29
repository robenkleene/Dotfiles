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

```
class Foo {
public:
    Foo(int barIn) : bar(barIn) { }
private:
    int bar;
};
```

# Destructors

Including a default destructor ensures that deleting a class through a base class pointer, also calls derived class destructors:

```
  virtual ~Foo() = default;
```

# `virtual` & `override`

- When a function is specified as `virtual` and another function uses `override`, if the `virtual` function returns a base type and the `override` function returns a derived type then the derived type will be "sliced" on return, removing the `derived` information from the base type.


