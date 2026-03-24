# 1. Install `lldb-server` and make it executable

```
adb push <path-to-lldb-server> /data/local/tmp/lldb-server-arm64/lldb-server
adb shell chmod +x /data/local/tmp/lldb-server-arm64/lldb-server
```

# 2. Start port forwarding

```
 adb forward tcp:5039 tcp:5039
```

# 3. Start the server attached to the process

```
adb shell /data/local/tmp/lldb-server-arm64/lldb-server g --attach `adb shell pidof com.oculus.vrshell` :5039
```

# 4. Run `lldb`

Setup the target:

```
(lldb) target create <path-to>/unstripped_native_libraries.links/arm64/<lib-name>.so
(lldb) settings set target.exec-search-paths <path-to>/unstripped_native_libraries
```

Connect to the server:

```
gdb-remote localhost:5039
```

# Optional

Set the platform to Android (`gdb-remote localhost:5039`) should do this automatically.

```
platform select remote-android
```
