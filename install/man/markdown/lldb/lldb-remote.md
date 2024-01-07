# `lldb` Remote

1. Install `lldb-server` to the device, e.g., `adb push lldb-server /data/local/tmp`
2. On the device, start the server, e.g., `adb shell`, then `/data/local/tmp/lldb-server platform --listen "*:10086" --server` (`10086` is an arbitrary port number)
3. On the device, start port forwarding `adb forward tcp:10086 tcp:10086`
4. On the computer, get the device name with `adb devices`
5. Start `lldb`, then `platform select remote-android` and then connect using the device name `platform connect connect://<device-name>:10086`
6. In `lldb`, `platform process list` to list all the processes to connect to
7. Filter the process list with `platform process list -r .*<term>.*`, `-r` is for regular expression
