# `vim` `B`

B allows piping just a selection through a shell command, as opposed to whole lines, which is all `vim` supports by default.

## Tab Completion

Including `B` in the `vim` command line doesn't work with tab completion (e.g., `'<,'>B !f_` followed by tab won't complete shell commands that start with `f_`).

A workaround is to use `'<,'> !f_` to tab complete, then navigate to earlier in the command to add the B (e.g., use `<S-right>` to go back a word).
