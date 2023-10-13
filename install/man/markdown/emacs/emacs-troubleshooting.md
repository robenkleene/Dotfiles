%

# `emacs` Troubleshooting

- `emacs -q`: Open Emacs without loading init

## Auto Save Data

If on start up, there's a message that says a file `has auto save data`, navigate to that files directory in Dired, show hidden files, and then `D` to delete the auto save file.

## Profiling

1. `profile-start`: Do something slow
2. `profile-report`: See why something was slow
