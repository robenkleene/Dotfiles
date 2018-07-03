#!/usr/bin/env bash

# Test for a file with `.xcodeproj` exit and do nothign if it doesn't exist
for project_file in *.xcodeproj; do
  project_name=$(basename "$project_file")
  project_name="${project_file%.*}"
done

if [[ -z "$project_name" ]]; then
  echo "No .xcodeproj file found" 
  exit 1
fi

# `.gitignore`
setup_gitignore() {
  gitignore="# Xcode
#
# gitignore contributors: remember to update Global/Xcode.gitignore, Objective-C.gitignore & Swift.gitignore

## Build generated
build/
DerivedData/

## Various settings
*.pbxuser
!default.pbxuser
*.mode1v3
!default.mode1v3
*.mode2v3
!default.mode2v3
*.perspectivev3
!default.perspectivev3
xcuserdata/

## Other
*.moved-aside
*.xccheckout
*.xcscmblueprint

## Obj-C/Swift specific
*.hmap
*.ipa
*.dSYM.zip
*.dSYM

# CocoaPods
#
# We recommend against adding the Pods directory to your .gitignore. However
# you should judge for yourself, the pros and cons are mentioned at:
# https://guides.cocoapods.org/using/using-cocoapods.html#should-i-check-the-pods-directory-into-source-control
#
# Pods/

# Carthage
#
# Add this line if you want to avoid checking in source code from Carthage dependencies.
Carthage/Checkouts

Carthage/Build

# fastlane
#
# It is recommended to not store the screenshots in the git repo. Instead, use fastlane to re-generate the
# screenshots whenever they are needed.
# For more information about the recommended setup visit:
# https://docs.fastlane.tools/best-practices/source-control/#source-control

fastlane/report.xml
fastlane/Preview.html
fastlane/screenshots
fastlane/test_output

# Code Injection
#
# After new code Injection tools there's a generated folder /iOSInjectionProject
# https://github.com/johnno1962/injectionforxcode

iOSInjectionProject/"
  echo "$gitignore" > .gitignore
}

setup_travis() {
  travis="language: swift
osx_image: xcode9.3
script:
- make ci"
  echo "$travis" > .travis.yml
}

setup_makefile() {
  ci_steps="lint test"
  if [[ -f "Cartfile" ]]; then
    ci_steps="line bootstrap test"
  fi
  makefile="SCHEME = $project_name

.PHONY: build test lint autocorrect swiftformat swiftlint_autocorrect bootstrap

ci: $ci_steps
ac: autocorrect
autocorrect: swiftformat swiftlint_autocorrect

lint:
	swiftlint --strict

swiftformat:
	swiftformat --commas inline --exclude Carthage .

swiftlint_autocorrect:
	swiftlint autocorrect

build:
	xcodebuild build

bootstrap:
	carthage bootstrap

test:
	xcodebuild test \\
		-alltargets \\
		-configuration Debug \\
		-scheme \$(SCHEME)"
  echo "$makefile" > Makefile
}

# `.swiftlint.yml`
setup_swiftlint() {
  swiftlint="disabled_rules:
  - function_parameter_count
  - xctfail_message
  - identifier_name
  - file_length
excluded:
  - Carthage"
  echo "$swiftlint" > .swiftlint.yml
}

setup_gitignore
setup_travis
setup_makefile
setup_swiftlint
