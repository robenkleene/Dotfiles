# `adb` `logcat`

- `adb logcat`: Stream log
- `adb logcat -d`: Dump log and then quit
- `adb logcat -c`: Clear log

## For Bug Report

Clear and capture log:

```
adb logcat -c && adb logcat > logcat.txt
```

## Log Size

```
adb logcat -G 64M
```
