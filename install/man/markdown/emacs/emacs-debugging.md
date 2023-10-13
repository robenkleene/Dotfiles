%

# `emacs` Debugging

- `(debug)`: Pause in debugger when this is called
- `check-parens` to check document parens
- `C-M-x`: Eval defun
- `C-u C-M-x`: edebug defun

Enabled debugger:

	(setq debug-on-error t)

On startup:

	emacs --debug-init

Debug a function:

	M-x debug-on-entry <function-name>

Debugger:

- `d`: Step forward
- `c`: Continue

## Profiling

- Use `elp-instrument-package` (then a package, e.g., `compilation`) then `elp-results`.
- Use `profiler-start` then `profiler-stop` then `profiler-report`.

## Debugging Desktop Restore

If there are problems restoring windows on startup (with the `(desktop-save-mode 1)` option on), then turn on debugging with `(setq debug-on-error t)`, then run `desktop-revert`, this should catch the error in the debugger.
