# Print variable

``` cpp
std::cout << "$1 = " << ${1} << std::endl;
```

# Print

``` cpp
std::cout << "${1:Message}" << std::endl;
```

# C++ template

``` cpp
#include <iostream>

int main() {
  std::cout << "Hello, World!" << std::endl;
}

```

# Main function

``` cpp
int main() {
  ${1:std::cout << "Hello, World!" << std::endl;}
}
```

# Include for `cout`

``` cpp
#include <iostream>
```

# Print this address

``` cpp
std::cout << this << std::endl;
```

# Print address of object

``` cpp
std::cout << " &$1 = " << &${1} << std::endl;
```

# Print enum

``` cpp
std::cout << " $1 = " << static_cast<int>(${1}) << std::endl;
```

# Print format string address of object

``` cpp
std::cout << " &$1 = %p" << &${1} << std::endl;
```

# Print array

``` cpp
std::cout << "${1} = ";
for (std::size_t i = 0; i < $1.size(); ++i) {
  std::cout << (i > 0 ? ", " : "") << $1[i];
}
std::cout << std::endl;
```

# Print map

``` cpp
std::cout << "${1} = {";
bool first = true;
for (const auto& pair : values) {
  if (!first) {
    std::cout << ", ";
  }
  std::cout << "{" << pair.first << ": " << pair.second << "}";
  first = false;
}
std::cout << "}" << std::endl;
```

# For loop

``` cpp
for (int ${1:i} = 0; $1 < ${2:10}; $1++) {
    $0
}
```

# For loop array

``` cpp
for (std::size_t ${1:i} = 0; $1 < ${2}.size(); ++$1) {
    ${3:std::cout << $2[$1] << std::endl;}
}
```

# For loop array range

``` cpp
for (int ${1:element} : ${2}) {
    ${3:std::cout << $1 << std:endl;}
}
```

# For loop array iterator

``` cpp
for (auto it = ${1:arr}.begin(); it != $1.end(); ++it) {
    ${2:std::cout << *it << std::endl;}
}
```

# Suppress gMock warnings

``` cpp
::testing::FLAGS_gmock_verbose = "error";
```

