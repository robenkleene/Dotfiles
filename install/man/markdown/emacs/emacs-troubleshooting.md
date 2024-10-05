- `emacs -q`: Open Emacs without loading init

# Auto Save Data

If on start up, there's a message that says a file `has auto save data`, navigate to that files directory in Dired, show hidden files, and then `D` to delete the auto save file.

# Profiling

1. `profiler-start`: Start profiler
2. `profiler-stop`: Stop profiler
3. `profiler-report`: See report

# Profiling Startup

## Profiling `use-package`

1. Add `(setq use-package-compute-statistics t)` to Emacs configuration
2. Run `use-package-report` after startup
