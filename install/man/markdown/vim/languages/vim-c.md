%

# C

C has a couple of characteristics that making working with it unique in Vim.

Unlike with most languages, `ctags` doesn't index the standard library. But the C standard library is documented in `man` pages, so you can look up a function declaration where the cursor is for standard library functions with the `K` command.

For viewing included header files in the standard library, with the following in `ftplugin/c.vim`, Vim's `gf` command can be used to jump an included header file where the cursor is.

	setlocal path+=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/
