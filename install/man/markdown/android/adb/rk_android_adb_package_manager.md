- `pm` is an alias to `cmd package`
- `adb shell pm`: Package manager help
- `adb shell pm list packages`: List installed package names (APKs)
- `adb shell pm resolve-activity --brief <package-name>`: List activities for a package
- `adb shell pm clear <package-name>`: Clear data for a package
- `adb shell dumpsys package com.meta.mr.awe | grep version`: Get a package version

## Package Name

The `com.foo.bar` string is called a `Package Name`

## Launch

- `adb shell am start -n $(adb shell pm resolve-activity --brief <com.package.name/com.package.name.ActivityName> | tail -1)

### Long

1. `adb shell pm list package | rg -i <term>`: Get the package name
2. `adb shell pm resolve-activity --brief com.package.name`
3. `adb shell am start -n <com.package.name/com.package.name.ActivityName>`
