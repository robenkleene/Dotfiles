%

# `vim` `xargs`

To avoid the dreaded "Input is not from a terminal" with `xargs`, use the `-o` flag with `xargs` which reopens stdin on the child process (it should always be used with interactive applications).

E.g., `p | tr "\n" "\0" | xargs vim -0 -o`
