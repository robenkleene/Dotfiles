# `adb`

- `adb reboot`: Reboot
- `adb devices`: List devices

## `adb shell`

Use `adb shell`: Start an `adb` shell session, in the session:

- `ps -A`: List processes
- `ps -A | grep <term>`: Works for searching
- `which ps`: Works for finding commands

## Debugging

1. In `adb shell`, start the server with `gdbserver :5045 --attach <pid>`
2. In a local shell, run `adb forward tcp:5045 tcp:5045` to enable the port forwarding
3. Run `lldb` in a local shell
4. In `lldb`, run `gdb-remote localhost:5045`
