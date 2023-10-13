%

# Ruby Troubleshooting

## Library not loaded

An error like this can appear when running Ruby if the version of a library Ruby was compiled against gets removed. This often happens with `openssl`, the error includes line like this:

	Library not loaded: /usr/local/opt/openssl/lib/libcrypto.1.0.0.dylib (LoadError)

What's happened in this case is that Homebrew has updated `openssl` and that `dylib` is no longer at that location.

The easiest way to fix this is to just delete and re-install Ruby and it will be installed with a reference to the newer version of `openssl`.
