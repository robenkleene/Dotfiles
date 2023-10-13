%

# `chruby`

- `chruby`: List available rubies
- `chruby system`: Use system Ruby
- `chruby_use /usr/`: Switch to Ruby by path

## Gems

`sudo gem install`: Installs to `/path/to/$ruby/$gemdir`
`gem install`: Installs to `~/.gem/$ruby/$version`

### Notes

After installing a Ruby with `chruby`, some gems will be installed by default (in the "root" location):

	~/.rubies/ruby-2.5.3/lib/ruby/gems/2.5.0/gems
