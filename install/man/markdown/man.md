%

# `man`

To access the second `man` page, e.g., `unlink(2)`, use `man 2 unlink`

## Example

       less -?
       less --help
       less -V
       less --version
       less [-[+]aBcCdeEfFgGiIJKLmMnNqQrRsSuUVwWX~]
            [-b space] [-h lines] [-j line] [-k keyfile]
            [-{oO} logfile] [-p pattern] [-P prompt] [-t tag]
            [-T tagsfile] [-x tab,...] [-y lines] [-[z] lines]
            [-# shift] [+[+]cmd] [--] [filename]...
       (See  the  OPTIONS section for alternate option syntax with long option
       names.)

### Manual Page Syntax

From `man manpages`:

- Anything in a normal text font is required text.
- **Underline**: Anything underlined is a user-specified argument such as a filename.
- **Brackets ([])**: Any argument surrounded by brackets is considered to be optional.
- **Vertical Separator (|)**: Flags, arguments, or subcommands separated by a vertical separator (|)
     are mutually exclusive.
- **ellipsis (...)**: Indicates that additional arguments may be added at
     this point.
