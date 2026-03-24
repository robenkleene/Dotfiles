- `M-S-d`: Unwrap s-expression, e.g., remove parenthesis or quotes
- `C-M-b` / `C-M-f`: Move forward and backward by s-expression
- `C-M-SPC`: Select current s-expression
- `C-M-w`: Copy s-expression

# Fixing Issues

After pasting in text, often the parenthesis are unbalanced, use this command to fix it:

- `C-q` (`quoted-insert`): This can be used to enter a single pair character to fix the balance issues (to remove a single pair character, delete the pair, then use `C-q` to enter a single pair character)
