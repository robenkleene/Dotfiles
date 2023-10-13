%

# Gem Management

## The Problem

If a Ruby script is run from the command-line that has a shebang that sets a different Ruby than the default Ruby, then this will cause an inconsistency between the Ruby binary and the gem configuration.

Here's an example of a shebang line that overrides the default Ruby:

	#!/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby

## The Workaround

The work around is to use a `.ruby-version` file to override the current version of Ruby. This should be done in any directory that has Ruby files with shebangs that override the default ruby.

## System Ruby

Use system Ruby for Repla:

	chruby system

When installing system gems, use `--user-install` to avoid cluttering the system Ruby space:

This installs gems at `/Users/robenkleene/.gem/ruby/2.3.0`. (Note that this does not require `sudo`.)

Since the default executable path is not setup by default, bundler and rake must specify it when being installed:

	gem install --user-install bundler --bindir /usr/local/bin
	gem install --user-install rake --bindir /usr/local/bin

### Restoring Default `gems`

These are probably supposed to be installed by default, if they get deleted, use these commands to restore them to `/Library/Ruby/Gems/2.3.0/`

	sudo gem install test-unit
	sudo gem install power_assert

## Correct Installation

Here's how Bundler should work after being correctly installed:

	$ which bundle
	/Users/robenkleene/.gem/ruby/2.5.3/bin/bundle
	$ chruby system
	$ which bundle
	/usr/local/bin/bundle

Note that for system Ruby, the gem directory is `2.3.0` (not `2.3.7`):

	$ ls .gem/ruby
	2.3.0  2.5.3
