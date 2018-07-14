#!/usr/bin/env bash

# TODO: Read the `.setup_xcode` file and add the contents as flags, one
# flag per line
# This can probably be done by editing the arguments array
# Test like this `setup_xcode -h` should exit

args=("$@")
if [[ -f ".setup_xcode" ]]; then
  while read -r line || [[ -n "$line" ]]; do
    args+=("$line")
  done < ".setup_xcode"
fi

build_only=false
setup_deploy=false
has_cartfile=false
if [[ -f "Cartfile" || -f "Cartfile.private" ]]; then
  has_cartfile=true
fi

set_args() {
  while getopts "tbh" option
    do case "$option" in
      b)
        build_only=true
        ;;
      t)
        setup_deploy=true
        ;;
      h)
        echo "Usage: setup_xcode [-hb]"
        echo
        echo "Create a file called .setup_xcode to automatically set flags."
        echo "Put one flag per line."
        exit 0
        ;;
      \?)
        echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    esac
  done
}

set_args ${args[@]}

# Test for a file with `.xcodeproj` exit and do nothign if it doesn't exist
shopt -s nullglob
for project_file in *.xcodeproj; do
  project_name=$(basename "$project_file")
  project_name="${project_file%.*}"
done
shopt -u nullglob

if [[ -z "$project_name" ]]; then
  echo "No .xcodeproj file found" 
  exit 1
fi

# `.gitignore`
setup_gitignore() {
  local gitignore="# Xcode
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

iOSInjectionProject/
"
  echo "$gitignore" > .gitignore
}

setup_travis() {
  local travis="language: swift
osx_image: xcode9.4
script: make ci
xcode_project: $project_name
xcode_scheme: $project_name
env:
  global:
  - FRAMEWORK_NAME=$project_name
"
  if $has_cartfile || $setup_deploy; then
    travis+="before_install:
- brew update
- brew outdated carthage || brew upgrade carthage
"
  fi
  if $setup_deploy; then
    travis+="before_script:
- make lint
before_deploy:
- carthage build --no-skip-current
- carthage archive \$FRAMEWORK_NAME
"
    if [[ -f ".travis.yml" ]]; then
      # The deploy section needs to be setup manually because it includes an
      # encrypted key, so we overwrite the begginging of the file and preserve
      # the end which includes the manual section.
      # The `expr` `+ 0` removes whitespace.
      local travis_lines="$(expr $(wc -l <<< "$travis") + 0)"
      local travis_deploy=$(tail -n +$travis_lines .travis.yml)
      travis+=$travis_deploy
    fi
  fi
  echo "$travis" > .travis.yml
}

setup_makefile() {
  local ci_steps
  if $build_only; then
    ci_steps="build"
  else
    ci_steps="test"
  fi
  local makefile="SCHEME = $project_name

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
		-scheme \$(SCHEME)
"
  echo "$makefile" > Makefile
}

# `.swiftlint.yml`
setup_swiftlint() {
  local swiftlint="disabled_rules:
  - closure_parameter_position
  - file_length
  - function_body_length
  - function_parameter_count
  - identifier_name
  - todo
  - type_name
  - xctfail_message
excluded:
  - Carthage
"
  echo "$swiftlint" > .swiftlint.yml
}

setup_gitignore
setup_travis
setup_makefile
setup_swiftlint
