# `cpp` Print

Without `<< std::endl` a trailing new line won't be printed

Print a message:

```
#include <iostream>
std::cout << "foo" << std::endl;
```

Print an `enum`:

```
#include <iostream>
std::cout << "enum = " << static_cast<int>(enum) << std::endl;
```

Print a memory address:

```
#include <iostream>
std::cout << "&foo = %p" << &foo << std::endl;
```
