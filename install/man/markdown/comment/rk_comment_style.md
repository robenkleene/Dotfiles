- Comments should explicitly reference the specific syntax they explain, not just describe behavior abstractly
- Include the relevant symbol, keyword, or construct directly in the comment so the reader knows exactly what it refers to
- Wrap referenced code in backticks (e.g., `<code>`) in the comment

## Examples

Good:

```sh
# `${[@]+}` syntax avoids empty array being unbound under `set -u`
for part in "${dir_parts[@]+"${dir_parts[@]}"}"; do
```

```sh
# `${parts[-1]}` not supported in older bash, use `${#parts[@]}-1` instead
last="${parts[${#parts[@]}-1]}"
```

```python
# `__slots__` prevents dynamic attribute creation, reducing memory usage
__slots__ = ('x', 'y')
```

Bad:

```sh
# Avoid unbound variable error
for part in "${dir_parts[@]+"${dir_parts[@]}"}"; do
```

```sh
# Negative indices not supported in older bash
last="${parts[${#parts[@]}-1]}"
```

```python
# Reduces memory usage
__slots__ = ('x', 'y')
```
