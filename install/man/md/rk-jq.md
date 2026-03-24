- `-S` / `--sort-keys`

# Examples

- `jq -R -s '.'`: String escape standard input

## Print Matching Object

- `jq '.. | objects | select(.<key> == "<value>")'`: Print an object where a `<key>` matches a `<value>`

### Explanation

```
jq '.. | objects | select(.<key> == "<value>")'
    ^ Recursive
         ^ Match objects
                   ^ Select matching key
```
