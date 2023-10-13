%

# Bash Test

Safely testing for a unbound variable (this allows `set -u` to be on to fail if an unbound variable is found):

    if [[ -n "${file_path-}" ]]; then
