- `./a.out 2>/dev/null`: Discard standard error
- `echo "Error" >&2`: Discard standard output to standard error
- `./a.out 2>error.log`: Redirect standard error to a file
- `./a.out >output.log 2>&1`, `./a.out &>output.log`: Redirect standard error and standard output to a file (note in the first example, that order matters, this won't work if the file is specified second)
- `./a.out 2>&1 | tee output.log`: Redirect standard error and standard output to a file and print to standard output
- `./a.out 2>&1 | tee /dev/tty | sort`: Redirect standard error and standard output to a pipe and to standard output

# Ordering

The reason `./a.out >output.log 2>&1` redirects both standard error and standard output to a file but `./a.out 2>&1 >output.log` doesn't is because `2>&1` means *redirect standard error to where standard output is pointing* if this is done before redirecting standard output to a file, then standard output is still pointing at `/dev/tty` so that's where standard error goes, where as if it's done after `>output.log` then standard output is now pointing at the file, so that's where standard error goes.

