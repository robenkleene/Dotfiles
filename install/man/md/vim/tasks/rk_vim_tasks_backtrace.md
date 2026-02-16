# Vim Tasks Backtraces

Backtraces are usually only shows filenames with line numbers like `<filename>:<line-number>:<column-number>` (i.e., without relative or absolute paths). In a pinch, a quick way to be able to jump to these locations is to set `setl path+=**` to add recursive search to just the buffer with the backtrace.
