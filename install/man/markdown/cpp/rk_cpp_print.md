# Logging Multiple Callstack Levels

Sometimes you need to log something at one callstack level with state at another call stack level.

This can be accomplished by passing a string argument in to a function, appending to that string variable, and then printing the result in the calling function.

Calling function:

```
// Make a `logging` string pointer
std::unique_ptr<std::string> logging = std::make_unique<std::string>();
// Pass it as a reference to the lower-level function to debug
foo(bar, *logging);
```

```
#include <sstream>

// ...

// Use overloading so other callers to the original function still compile
void foo(int bar) {
    std::unique_ptr<std::string> logging = std::make_unique<std::string>();
    foo(bar, logging);
}
// In the lower-level function to debug, appending to the `logging` variable
void foo(int bar, std::string& logging) {
    // ...
    std::stringstream ss;
    ss << "worldToUnitGeometry = " << MathCommon::ToString(worldToUnitGeometry);
    logging += ss.str();
}
```

Also update the header for `foo`:

```
void foo(int bar, std::string& logging) {
```
