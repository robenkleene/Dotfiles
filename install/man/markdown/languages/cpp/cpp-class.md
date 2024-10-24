# `cpp` Class

- Functions marked `static` don't rely on instance-specific member variables or method (i.e., class method vs. instance method)

## Check if an object is a particular class

```
if (dynamic_cast<foo*>(bar) != NULL) {
    std::cout << "&bar = %p" << &bar << std::endl;
}
```
