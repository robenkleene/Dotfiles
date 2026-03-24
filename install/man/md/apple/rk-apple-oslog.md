- `os_log` uses the `StaticString` data type:

		let foo: StaticString = "Something happened."
		os_log(foo)

- Log data is kept in a compress binary format `tracev3`
- Logging has three basic levels: `Default`, `Info`, and `Debug`; and two special levels: `Fault`, and `Error`
- Use `com.company.MyApp` for application-level logs and `com.company.MyApp.SomeFramework` for framework-level logs
- "Don't include symbol information or source file line numbers in messages. The system automatically captures this information."
- Log messages cannot be disabled from printing in Xcode console [source](https://stackoverflow.com/questions/41142848/how-do-you-disable-os-log-info-and-os-log-debug-messages-in-xcode-console?rq=1)
## A Swift Example

Here's some sample code in Swift:

	let logHandle = OSLog(subsystem: "com.example.widget", category: "Setup")
	os_log(.info, log: logHandle, "Hello, %{public}s!", world)

## `log` Commane-Line Tool

Stream live log messages (is this filtered by app?):

	log stream

Only show matching events:

	log stream --predicate 'eventMessage contains "my message"'

Display an archive:

	log show system_logs.logarchive

For a single app (what's the config command do?):

	log config --mode "level:debug" --subsystem com.mycorp.myapp

This probably shows the log message?

	xcrun simctl spawn booted log show system_logs.logarchive

What's the difference between `logarchive` and `tracev3`?

## Creating a Log Object

Defaults to system behavior

	os_log_t log = os_log_create("com.your_company.subsystem", "network");

	os_log(log, "This happened");

"Reference to category and subsystem stored with every log message" What's this mean?

## Message Level Behavior

- **Default**: Always enabled, goes to disk
- **Info**: Enabled, in memory
- **Debug**: Not enabled, N/A for in memory

### Special

- **Error**: Always, disk
- **Fault**: Always, disk

### Guidelines

- `os_log`: Log critical details to help debug issues
- `os_log_info`: Log additional info that will be captured during error or fault
- `os_log_debug`: High-volume debugging during development
- `os_log_error`: Cause additional information to be captured from app
- `os_log_fault`: Cause additional information to be captured from system
