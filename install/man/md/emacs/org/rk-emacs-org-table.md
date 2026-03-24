# Creating

Create a table by typing out the header names separated by `|`, e.g.:

```
|Expression|Result<tab>
```

# Calculations

- `C-u C-c C-c`: Evaluate the whole table
- `C-c =` to enter an expression in a cell, e.g., `(calc-eval $1)` evaluates the contents of the first column (`$1`)
- Add `$2='(calc-eval $1)` below the table to add a default expression
- Usually `@>$2='(calc-eval $1)` is better because it excludes the first row (which can then be used for headers)

## Example

```
| Expression | Result |
| 14 * 29    |    406 |
#+TBLFM: @>$2='(calc-eval $1)
```
