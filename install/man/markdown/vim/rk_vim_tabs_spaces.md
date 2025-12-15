# Convert Tabs to Spaces

```
set expandtab
retab!
```

Or pipe through `expand` command-line program (e.g., `:%w !expand`).

# Convert Spaces to Tabs

```
set noexpandtab
retab!
```

Or pipe through `unexpand` command-line program (e.g., `:%w !unexpand -t 2` [`2` is number of spaces per tab, default is `8`]).

# Insert Literal Tab

If `expandtab` is set, entering `⇥` in insert mode or on the command line, will enter spaces instead, to enter a literal tab, use `<C-v><tab>`.
