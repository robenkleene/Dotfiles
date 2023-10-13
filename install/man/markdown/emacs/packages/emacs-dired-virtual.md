# Emacs Dired Virtual

- `ls -l`: Output that can be converted to a `dired-virtual` buffer (i.e., you need the additional metadata for it to work)
- `ls -l **/*.md`: In Fish shell, this is the easiest way to get a recursive file list that works with `dired-virtual`
- `fd --strip-cwd-prefix -g "*.js" -l`: For `fd` output compatible with `dired-virtual`
