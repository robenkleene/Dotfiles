%

# `vim` Notes

## `.vimrc` Subtlety

* `vimrc` is loaded before plugins
* Only put the minimum in the `after/plugin` folder because re-sourcing your `vimrc` won't reload these.

## Running Tests

Set a make program:

	:set makeprg=testrb\ %

Then run tests with:

	:make

# Indent

To turn off auto-indent, try:

	filetype plugin indent off
