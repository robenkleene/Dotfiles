- `:make` always runs the `makeprg` relative to the current working directory *and that can't be changed after running*, so if `:make` outputs paths for the `quickfix` list, then `:make` has to be run in the working directory those paths are relative to)

# `makeprg`

```
set makeprg=gcc\ %
```

Or

```
let &makeprg = 'gcc %'
```

## Pipes

Pipes need to be escaped.

```
set makeprg=echo\ \"Hello\ World\"\ \\\|\ pbcopy'
```

```
let &makeprg = 'echo "Hello World" \| pbcopy'
```
