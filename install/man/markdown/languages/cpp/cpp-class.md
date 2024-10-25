- Functions marked `static` don't rely on instance-specific member variables or method (i.e., class method vs. instance method)

# Constructors

In this case `foo` will be set to an instance of the class calling the default constructor:

``` cpp
class Foo { }
int main() {
  Foo foo;
}
```

# Check if an object is a particular class

``` cpp
if (dynamic_cast<foo*>(bar) != NULL) {
  std::cout << "&bar = %p" << &bar << std::endl;
}
```
