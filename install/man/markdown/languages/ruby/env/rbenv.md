%

# `rbenv`

## Installing Ruby Versions

List available `ruby` versions:

	rbenv install -l

List installed versions:

	rbenv versions

Installing a Ruby version:

	rbenv install 2.0.0-p247

## Setting the current Ruby version

Print the current version:

	rbenv global

Setting by writing to the `~/.rbenv/version`:

	rbenv global 1.9.3-p194

Setting by the `RBENV_VERSION` environment variable:

	export RBENV_VERSION=1.9.3-p194

## Installation Instructions

1. Install `rbenv` via Homebrew:

		brew install rbenv ruby-build

2. Add `eval "$(rbenv init -)"` to your `.bash_profile`.
3. install Ruby version 1.9.3-p194

		rbenv install 1.9.3-p194

4. Set `rbenv` to use this version of Ruby:

		rbenv global 1.9.3-p194

5. Confirm the Ruby version:

		$ ruby -v
		ruby 1.9.3p194 (2012-04-20 revision 35410) [x86_64-darwin13.1.0]
