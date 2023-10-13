# `qmv`

Opens a document in `$EDITOR` where the paths to move to can be edited.

Installed with `brew renameutils`, more information here [renameutils home](http://www.nongnu.org/renameutils/).

There's a similar utility for copying called `qcp`.

Just do `qmv` followed by the file path.

Works great with `rg`:

	rg --files -g "WCL*" -0  | xargs -0 qmv

## Interactive Mode

If there's a problem with the rename plan, interactive mode is entered.

- `help`: Display help
- `apply`: Do all the valid renames
