- `jq -R -s '.'`: String escape standard input
- `jq '.. | objects | select(.<key> == "<value>")'`: Print an object where a `<key>` matches a `<value>`

## Breakdown

```
jq '.. | objects | select(.<key> == "<value>")'
    ^ Recursive
         ^ Match objects
                   ^ Select matching key
```
