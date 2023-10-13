# Gem Troubleshooting

Each time this command is run:

    repla server "bundle exec jekyll serve --watch --drafts --config _config_local.yml"

This error is getting dumped to the console:

    Ignoring commonmarker-0.17.13 because its extensions are not built. Try: gem pristine commonmarker --version 0.17.13

This is probably related to having installed a bunch more Gems at `~/.gem/ruby/2.5.3/gems` to support the release notes blog.

This reason this happens:

1. Bash runs the `#!/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby` executable
2. The gem paths are pointed to the `2.5.3` gems, so it attempts to load gems for 2.5.3 while running the 2.3 binary.

It looks like this can be fixed by adding `--disable-gems` to the shebang line.
