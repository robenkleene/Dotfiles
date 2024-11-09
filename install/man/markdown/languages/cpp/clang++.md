# Versions

- Specify a version with the `--std=c++20` flag

## Compile Flags

Add a `compile_flags.txt` file to the project directory with `-std=c++20` as the contents.

- Note that this will also get picked up and cause issues with other source code files in the same directory, e.g., the `sourcekit` LSP for Swift will attempt to use a `-std=c++20` flag and fail.

# On macOS

The `clang++` installed by Xcode uses `C++98` by default.

# Determining Default C++ Version

Run `clang++ -dM -E -x c++ /dev/null | grep __cplusplus`, results in output like:

```
#define __cplusplus 201402L
```

This corresponds to `C++14`, because 2014 means standardized in 2014.
