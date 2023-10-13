%

# Bundler

## Details

- `bundle install`: Will install to your gem path by default
- `bundle install --deployment`: Will install gems locally

## Install `vender/bundle`

This is the preferred way to install gems because it does not clutter up the global gem space (which should only be used for globally available executable gems). E.g., consider the case of having several blogs all on different versions of Jekyll: All this versions need to be installed globally, and when they get updated, the old versions will all sit around forever. Globally installed executables usually don't have this problem, because they are often run without a project requiring a specific version. Note that this is not the standard convention, it's personal preference.

This command is deprecated but still works:

	bundle install --path vendor/bundle

The new command is:

    bundle config set path 'vendor/bundle'

This will install gems locally to `vendor/bundle`, and setup a configuration file at `.bundle/config`. Once a `.bundle/config` is setup to specify `BUNDLE_PATH: "vendor/bundle"`, all `bundle update` and `bundle clean` commands will operate based on that folder.

## Update

`bundle update` will update all gems. If there's a `BUNDLE_PATH` specified in `.bundle/config`, that directory will be used, otherwise it will update global gems.

## Clean Up

`bundle clean` will delete all old no longer referenced gems.

If there's not a config at `.bundle/config`, a message will be printed that this will delete all gems from the global gem space that aren't referenced by the local `Gemfile`.

It's a good idea to run `gem source -c` (`gem source --clean-all`), after doing a global bundler clean up, this will delete cached gem specs at `~/.gem/specs`.

## Updating Global Gems

In the directory with the global `Gemfile`:

1. `bundle update`
2. `bundle clean --force`

## Standalone

Standalone is used to be able to run projects without needing `bundle exec`, e.g., for environments where the `bundle` CLI may not be installed.

1. Run `bundle init` to create a `Gemfile`
2. Add `.bundle` to `.gitignore`
3. Edit the `Gemfile` to add required gems
4. Run `bundle install --standalone`
5. Add `require_relative 'bundle/bundler/setup'` to the script

### Updating Standalone

	bundle update <gem name> --full-index
	bundle install --standalone
	bundle update
	bundle clean
	bundle install --standalone

Note the second `bundle install --standalone` is necessary to update the `bundle/bundler/setup` to point to the new version of the gem.

#### Troubleshooting

If a gem won't update, the following can be tried:

1. Specify the gem: `bundle update repla`
2. Use the `--full-index` option: `bundle update repla --full-index`

## Updating the Ruby Version

1. Add `ruby '2.0.0'` to the `Gemfile`
2. Delete the `.bundle` directory
3. Delete the `bundle` directory
4. Delete the `Gemfile.lock` file
4. Run `bundle install --standalone`

## `git` in Gemfile

To point to a development version of a gem:

	gem 'repla', github: 'repla-app/repla-ruby', branch: 'catalina'

Then the following will add the gem and remove the previous version:

	bundle update # Install them gem
	bundle clean # Delete the old version of the gem
	bundle install --standalone # Point the `bundle/bundler/setup` at the gem

### Adding to `git`

Since Bundler checkouts the gem from git, if you then try to add the gem to git (e.g., with `git add .`), the add will fail with a message about recursively adding git repositories ("You've added another git repository inside your current repository."). In order to add it, you'll need to use `git add <full path to repository>/`, e.g.:

	git add Contents/Resources/bundle/ruby/2.4.0/bundler/gems/repla-ruby-4992e5e09082/

Note that the trailing slash is important.

## Running `gem` Commands

Running `gem` commands with `bundle exec` works (but this probably won't solve your problem):

    bundle exec gem install ffi --version "1.15.5" -- --disable-system-libffi
    bundle exec gem uninstall ffi
