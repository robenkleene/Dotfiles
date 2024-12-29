# Vim Select

- `^R`: Selects the register that the replaced text gets saved in (by default it uses the small delete register [`"-`])
- `^G`: Switches to visual mode
- `^O`: Switches to visual mode for one command

## Snippets

Vim is cautious about making sure deleted text isn't accidentally lost, so it uses a register for replaced text in `select` mode (the small delete register [`"-`] by default).
So in `select` mode `^R` does not insert from a register (`^R` is normally how to insert from a register in insert mode).

Snippets switch the mode to `select` mode so that typing types over the tab stop placeholder text.

## Inserting Text From a Register at a Snippet Tab Stop

After the snippet has been expanded, and the contents to insert is in the unnamed register:

1. `^O` to enter visual mode
2. `P` to paste from the unnamed register
3. `i` to enter insert mode again
4. `<tab>` to continue snippet expansion (mirrored tab stops won't update until after this step)

- Another approach that works is to insert a character then delete it, after doing so, the behavior of `^R` will be restored to inserting from a register.
