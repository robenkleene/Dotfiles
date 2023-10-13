# `agvtool`

## `plist` Mappings

In Xcode's Target General Settings:

- **Build**: `CFBundleVersion`
- **Version**: `CFBundleShortVersionString`

In Xcode's Project "Build Settings" under "Versioning", in the `Info.plist`:

- **Current Project Version**: `CURRENT_PROJECT_VERSION`

## Setting up a new project

In Xcode, in the Target's "Build Settings" under "Versioning":

1. Set the "Versioning System" to `Apple Generic` 
2. Set the "Current Project Version" (e.g., `1`)

In the Target's in the Target's "General" settings:

1. Set the "Build" (e.g, `1`) *this must match the value for "Current Project Version" above*
2. Set the "Version" (e.g, `1.0`) 

## Commands

Print the current build number:

	agvtool vers

Print the current marketing version:

	agvtool what-marketing-version

Set the marketing version number (note that this will set the version number for all targets including test targets):

	agvtool new-marketing-version 1.0b1

Bump the build number:

	agvtool bump -all

### Bumping Build Number

`agvtool bump -all` increments the build number, which increments both:

1. The "Build" field in Xcode's Target General Settings, which is the `CFBundleVersion` in the `Info.plist`
2. The "Current Project Version", in Xcode's Project "Build Settings" under "Versioning", which is the `CURRENT_PROJECT_VERSION` in the `project.pbxproj` file.

This is why those two numbers much have the same value.



