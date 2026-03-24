- A `unique_ptr` is a wrapper around a raw pointer that removes the copy and copy assignment constructors to ensure there's only one owner of the managed object

# Code Samples

Member variable:

```
std::unique_ptr<Foo> foo;
```

Constructing:

```
std::unique_ptr<Foo> foo = std::unique_ptr<Foo>(bar); // `bar` is constructor parameter
```

Get raw pointer:

```
Foo *rawFoo = foo.get();
```

Accessing a member variable:

```
foo->bar
```

(`foo->bar` is implemented as operator overloading `foo->bar` is equivalent to `foo.get()->bar`)
