# Opening & Closing

- `za (zA)`: Toggle current fold (recursive)
- `zo (zO)` / `zc (zC)`: Open / close current fold (recursive)
- `zr (zR)` / `zm (zM)`: Increment / decrement fold Level (recursive)
- `zR` / `zM`: Open / close all folds
- `zf`: Create fold (for manual)
- `zi`: Toggle folding
- `zv`: Reveal cursor
- `zo` / `zc`: Open / close visually selected folds

# Navigation

- `zk` / `zj`: End of previous fold / start of next fold
- `[z` / `z]`: Start / end of current fold

# Examples

- `zMzv`: Close all except cursor (this is also a good workaround for not having a way to close all sibling folds)

# Fold Methods

## Manual

- Use the `zf` operator to mark a fold, e.g., `zf%` to fold between delimiters

## Indent

- The level of a fold is calculated by the indent of the line divided by the `shiftwidth`

# Troubleshooting

- The maximum number of nested folds supported by Vim is `20`, this is the default, and maximum, value of `foldnestmax`
