# 1. Install `lldb-server` and make it executable

```
adb push <path-to-lldb-server> /data/local/tmp/lldb-server-arm64/lldb-server
adb shell chmod +x /data/local/tmp/lldb-server-arm64/lldb-server
```


3. Start port 

2. `adb shell pidof <package-name>`


# Run `lldb`

```
(lldb) target create <path-to>/unstripped_native_libraries.links/arm64/<lib-name>.so
(lldb) settings set target.exec-search-paths <path-to>/unstripped_native_libraries
```

