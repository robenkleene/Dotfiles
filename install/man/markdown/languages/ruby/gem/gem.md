%

# `gem`

## Building Gems

	gem build webconsole.gemspec

Installing a gem locally:

	gem install webconsole-0.0.0.gem

## Publish Ruby Gem

	gem push webconsole-0.0.3.gem

## Where are Gems installed?

Printing installation locations:

	gem env

## Viewing Gem source code

	gem open sass

Requires `gem-open`:

	gem install gem-open

## Testing a Gem

	gem unpack websonsole-0.0.1.gem

Unpacks it in the current directory.

## Gem Cache

Clear gem cache:

	gem source --clean-all
	gem source -c

## Local, Global & System

Global gems are installed with `--system`, e.g., `gem install --system pry`.

`gem list` lists globally installed gems.

`bundle list` lists locally installed gems.

## Dependencies

List which gems depend on a gem:

    gem dependency ffi

## Uninstall

To uninstall all gems without prompting:

    gem uninstall -aIx

This usually errors out with some gems you'll have to install manually, then re-run the command.
