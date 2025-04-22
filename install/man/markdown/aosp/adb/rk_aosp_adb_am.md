- `adb shell am`: List activity manager help
- `adb shell am force-stop <package-name>`: Quit a process
- `adb shell am kill <package-name>`: Kill an process
- `adb shell am start -n com.package.name/com.package.name.ActivityName`: Launch a package (usually `adb shell am start -n "$1/$1.MainActivity"`)
- Use `adb shell ps` to see running processes

# Power Management

- `shell am broadcast -a com.oculus.vrpowermanager.prox_close`: Turn off power management
- `adb shell am broadcast -a com.oculus.vrpowermanager.automation_disable`: Turn on power management

# Performance

## Show HUD

`adb shell am broadcast -n com.oculus.ovrmonitormetricsservice/.SettingsBroadcastReceiver -a com.oculus.ovrmonitormetricsservice.ENABLE_OVERLAY`
`adb shell setprop debug.oculus.omms.enableOverlay true`

