%

# `cmake`

1. Creat a build directory `mkdir build` and `cd` into it
2. Run `cmake <path-to-destination>` (destination is where the `CMakeLists.txt` file is located, this usually means `cmake ..`)
3. Run `make` from the build directory (this is where `cmake` has generated the build assets)

## Debug vs. Release

Seems like release is the default, this creates a debug build:

- `cmake -DCMAKE_BUILD_TYPE=Debug ..`

## Add to Support `clangd`

```
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
```
