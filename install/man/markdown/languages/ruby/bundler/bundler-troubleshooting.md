%

# Bundler Troubleshooting

## Wrong Version of Ruby

If `echo $PATH` is showing one version of Ruby, but when executing commands like `rake` and `bundle` is using a different version of Ruby, this could be because a version of Ruby is hard-coded into the shebang line of the path. You can check this by running, the following command:

    head -n1 $(which bundle)

If that shows the wrong version of Ruby, then usually `gem install bundle` will fix it.

## Wrong Version of Bundler

To fix:

    can't find gem bundler (>= 0.a) with executable bundle (Gem::GemNotFoundException)

Get the `BUNDLED WITH` version from `Gemfile.lock` and run:

    gem install bundler -v <version>

A better solution is probably just to delete the `Gemfile.lock` and run `bundle install` again.
