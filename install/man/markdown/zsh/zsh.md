# `zsh`

- `exec zsh` to reload
- `^g`: Cancel

## Commands

- `rehash`: Rebuild auto-complete index
- `setopt`: List enabled options
- `unsetopt`: List disabled options

Simple way to get a key code: hit `^v` then the key.

## Help

- `man zshconrib`: Help for user contributions
- `man zshzle`: Some information about key bindings

## Customization

### Colors

List available colors:

	for code in {000..255}; do print -P -- "$code: %F{$code}Test%f"; done

Named colors

	autoload colors && colors
	echo ${(o)color} # or which colors

### Prompt

- `man zshmisc`: `/SIMPLE PROMPT ESCAPES` has a list of escape sequences

## Redirection

`1` is `stdout` and `2` is `stderr`.

- `1>filename` or `>filename`: Redirect `stdout` to a file
- `1>>filename` or `>>filename`: Redirect and append `stdout` to a file
- `2>filename`: Redirect `stderr` to a file
- `2>>filename`: Redirect and append `stderr` to a file
- `&>filename`: Redirect `stdout` and `stderr` to a file
- `2>&1`: redirect `stderr` to `stdout`
- `>/dev/null 2>&1`: Discard `stdout` and `stderr`
- `>/dev/null`: Discard `stdout`

## Functions

- `whence -f git-copy-remote-url`: Print function
