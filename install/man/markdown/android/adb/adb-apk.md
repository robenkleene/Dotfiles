%

# `adb` APK

- Install: `adb install <apk-path>`
- Uninstall: `adb uninstall <package-name>`
- Package Name: `adb shell pm list packages`
- Activity Name: `adb shell pm resolve-activity --brief <package-name>`
- Launch: `adb shell am start -n com.package.name/com.package.name.ActivityName`
- Quit: `adb shell am force-stop <package-name>`
- Kill: `adb shell am kill <package-name>`
