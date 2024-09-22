# clang++

## Determining C++ Version

Run `clang++ -dM -E -x c++ /dev/null | grep __cplusplus`, results in output like:

```
#define __cplusplus 201402L
```

This corresponds to `C++14`, because 2014 means standardized in 2014.
