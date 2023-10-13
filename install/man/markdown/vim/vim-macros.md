# `vim` Macros

* `qa`: Start recording a macro into register `a`
* `q`: Stop recording
* `@a`: Playback macro
* `@@`: Repeat last macro

## Editing an Existing Macro

### Quick Way

Just set the value of the register to be the intended macro:

	let @a='"bp'

To edit an existing Macro, use `<C-r>a` between the single quotes to paste the contents of that register.

### Elaborate Way

For more complex edits:

1. Create a new buffer with `:new`
2. Paste the contents of the macro: `"ap`
3. Make the edits
4. Copy the contents of the line: `^"ay$
