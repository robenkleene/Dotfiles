- `org-agenda`: Show menu (then hit e.g., `a` to show today)
- `org-agenda-list`: Show agenda (same as `M-x org-agenda a`)
- `C-c [`: Add current file to `org-agenda-files`
- `<return>`: Go to entry in this window
- `<tab>`: Go to entry in other window
- `m` / `u`: Mark / unmark item
- `B`: Bulk change marked items (e.g., `B s` to bulk reschedule)
- `C-c C-d` / `C-u C-c C-d`: Insert/change / remove deadline
- `C-c C-s` / `C-u C-c C-s`: Insert/change / remove schedule
- `C-c C-t`: Cycle todo state

## Tips

- Items can be rescheduled (e.g., with `S-<left>` / `S-<right>`) or marked as done (e.g., `C-c C-t`) from the agenda view

## Bulk Archive Todos

To bulk archive `DONE` todos when viewing a file:

1. `C-c a < t`: Show a list of todos for just this file
2. `1 r`: Filter to only `DONE` todos (`1` is the number for the `DONE` state)
3. `*`: Mark all (`m` marks only the item at point)
4. `B $`: Bulk archive
