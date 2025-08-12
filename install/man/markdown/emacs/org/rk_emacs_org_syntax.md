# Basic

- `*bold*`
- `/italic/`
- `_underlined_`
- `=verbatim=`
- `~code~`

# Document

Specifying a title:

```
#+title: Todo
```

Block quote:

```
> Quote
```

# Drawer

Drawers are useful for easily collapsible notes that aren't source code:

- `C-c C-x d`: Insert drawer (it will prompt for a drawer name)
- By convention, drawer names should be all caps
- Drawer's should start collapsed (e.g., `org-hide-drawer-startup` defaults to `t`), in practice this doesn't seem to be working

```
:<DRAWER_NAME>:
Drawer text
:END:
```
