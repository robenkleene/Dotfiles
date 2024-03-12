# Folding

- `zi`: Toggle folding
- `zv`: Reveal cursor
- `za (zA)`: Toggle current fold (recursive)
- `zo (zO)`: Open current fold (recursive)
- `zc (zC)`: Close current fold (recursive)
- `zr (zR)`: Increment Fold Level (recursive)
- `zm (zM)`: Decrement Fold Level (recursive)
- `zf`: Create fold (for manual)
- `zR`: Open all folds
- `zM`: Close all folds
- `zo` / `zc`: Open / close visually selected folds

## Navigation

- `zk` / `zj`: End of previous fold / start of next fold
- `[z` / `z]`: Start / end of current fold

## Combos

- `zMzv`: Close all except cursor

# Working With Folds

1. `zM`: Fold everything
2. `zr`: Repeat until there's the right level of visibility
3. `za`: Explore a single node

# Manual

- Use the `zf` operator to mark a fold, e.g., `zf%` to fold between delimiters

# Troubleshooting

- The maximum number of nested folds supported by Vim is `20`, this is the default, and maximum, value of `foldnestmax`
