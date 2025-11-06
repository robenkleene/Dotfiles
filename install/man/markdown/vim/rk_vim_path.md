# Vim Path

The `'path'` option is where files are searched for the following:

- `gf`, `gF`, `<C-w>f`, `<C-w>F`, `<C-w>gf`, `<C-w>gF`,
- `:find`, `:sfind`, `:tabfind`,
- `[i`, `]i`, `[I`, `]I`, `[<C-i>`, `]<C-i>`, `<C-w>i`, `:isearch`, `:ilist`, `:ijump`, `:isplit`, `:psearch`
- `[d`, `]d`, `[D`, `]D`, `[<C-d>`, `]<C-d>`, `<C-w>d`, `:dsearch`, `:dlist`, `:djump`, `:dsplit`,
- `<C-n>` and `<C-p>` in insert mode if you have `i` and/or `d` in `&complete`,
- `<C-x>i` and `<C-x>d` in insert mode,
- `findfile()`, `globpath()`, `getcompletion()`.

- `:find` is like `:edit` (e.g., it edits one file, in contrast to `:args` which edits multiple files), but `:find` uses the `'path'`

Default on Unix: `.,/usr/include,,` on other systems: `.,,`)

- `.` is the same directory as the current file
- An empty entry (`,,`) means search the working directory
- Adding `**` (`setlocal path+=++`) will add a recursive search
