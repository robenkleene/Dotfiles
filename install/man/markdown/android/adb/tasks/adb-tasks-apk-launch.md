# `adb` Launch

- `adb shell am start -n $(adb shell pm resolve-activity --brief <com.package.name/com.package.name.ActivityName> | tail -1) 

## Long

1. `adb shell pm list package | rg -i <term>`: Get the package name
2. `adb shell pm resolve-activity --brief com.package.name`
3. `adb shell am start -n <com.package.name/com.package.name.ActivityName>`
