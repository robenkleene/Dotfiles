# Build

- `xcodebuild -alltargets -configuration Debug`
- `-configuration Debug`: Configuration must be `Debug`, otherwise targets that use `@testable` will fail.
- `-alltargets`: Test targets won't be built without this

# Test

- `xcodebuild test -alltargets -configuration Debug -scheme MyScheme`

When running the `test` command, a scheme must also be specified.

## Only Testing

- `-only-testing:TestBundleA/TestSuiteA/TestCaseA`
- `-only-testing:TestBundleB/TestSuiteB`
- `-only-testing:TestBundleC`

# Other

- `xcodebuild -list`: List the schemes
- `xcodebuild -find clangd`: Show the path to a CLI tool
