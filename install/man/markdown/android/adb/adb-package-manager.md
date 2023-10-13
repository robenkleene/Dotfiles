%

# `adb` APK

- `pm` is an alias to `cmd package`
- `adb shell pm`: Package manager help
- `adb shell pm list packages`: List installed package names (APKs)
- `adb shell pm resolve-activity --brief <package-name>`: List activities for a package
- `adb shell pm clear <package-name>`: Clear data for a package
- `adb shell dumpsys package com.meta.mr.awe | grep version`: Get a package version
