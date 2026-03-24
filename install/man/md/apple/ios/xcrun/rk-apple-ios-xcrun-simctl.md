# iOS Simulator Logs

Note that `print` in Swift (and `printf` in Objective-C) do not show up here because those print to the process's standard output, instead of the system log. To print to the system log use `os_log` in Swift (or `NSLog` in Objective-C).

```
xcrun simctl spawn booted log stream --level=debug
```
