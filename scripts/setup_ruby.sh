#!/usr/bin/env bash

set -e

overwrite() {
  filename=$1
  contents=$2
  if [[ -f "$filename" ]]; then
    local existing_lines="$(expr $(wc -l <<<"$contents") - 0)"
    local existing=$(tail -n +$existing_lines "$filename")
    contents+=$existing
  fi
  echo "$contents" >"$filename"
}

# `.gitignore`
setup_gitignore() {
  local contents="*.gem
*.rbc
/.config
/coverage/
/InstalledFiles
/pkg/
/spec/reports/
/spec/examples.txt
/test/tmp/
/test/version_tmp/
/tmp/

# Used by dotenv library to load environment variables.
# .env

## Specific to RubyMotion:
.dat*
.repl_history
build/
*.bridgesupport
build-iPhoneOS/
build-iPhoneSimulator/

## Specific to RubyMotion (use of CocoaPods):
#
# We recommend against adding the Pods directory to your .gitignore. However
# you should judge for yourself, the pros and cons are mentioned at:
# https://guides.cocoapods.org/using/using-cocoapods.html#should-i-check-the-pods-directory-into-source-control
#
# vendor/Pods/

## Documentation cache and generated files:
/.yardoc/
/_yardoc/
/doc/
/rdoc/

## Environment normalization:
/.bundle/
/vendor/bundle
/lib/bundler/man/

# for a library or gem, you might want to ignore these files since the code is
# intended to run in multiple environments; otherwise, check them in:
# Gemfile.lock
# .ruby-version
# .ruby-gemset

# unless supporting rvm < 1.11.0 or doing something fancy, ignore this:
.rvmrc
"
  overwrite ".gitignore" "$contents"
}

setup_travis() {
  local contents="language: ruby
script: make ci
rvm: 2.5.3
branches:
  only:
    - master
"
  overwrite ".travis.yml" "$contents"
}

setup_makefile() {
  local contents=".PHONY: ci ac autocorrect lint

ci: lint
ac: autocorrect

lint:
	rubocop

autocorrect:
	rubocop -a
"
  overwrite "Makefile" "$contents"
}

setup_rubocop() {
  local contents="Metrics/PerceivedComplexity:
  Max: 16
Metrics/MethodLength:
  Max: 60
Metrics/AbcSize:
  Max: 60
Metrics/CyclomaticComplexity:
  Max: 16
Metrics/BlockLength:
  Max: 50
Metrics/ClassLength:
  Max: 200
Style/SymbolProc:
  # Style/SymbolProc can break when using map with refine in Ruby 2.4>
  Enabled: false
Style/FrozenStringLiteralComment:
  # This rule doesn't work when run locally
  Enabled: false
Style/SafeNavigation:
  # This rule doesn't work when run locally
  Enabled: false
Style/NumericPredicate:
  # This rule doesn't work when run locally
  Enabled: false
AllCops:
  TargetRubyVersion: 2.5
  Exclude:
    - '**/node_modules/**/*'
    - '**/vendor/**/*'
    - '**/bundle/**/*'
"
  overwrite ".rubocop.yml" "$contents"
}

setup_gemfile() {
  local contents="source 'https://rubygems.org'
ruby '2.5.3'
gem 'rubocop', '~> 0.76.0', require: false
"
  overwrite "Gemfile" "$contents"
  # rubocop complains about blank lines at the end of Gemfile
  sed -i '' '${/^[[:space:]]*$/d;}' "Gemfile"
}

setup_rubyversion() {
  local contents="2.5.3"
  echo "$contents" >.ruby-version
}

setup_gitignore
setup_makefile
setup_travis
setup_rubocop
setup_gemfile
setup_rubyversion
