- `set -e` / `set -o errexit`: Exit on non-zero exit status
- `set -o pipefail`: Fail if any command fails when using pipes, not just the last one
- `set -u` / `set -o nounset`: Error on unset variables (to test for a variable with this setting on use `${CODESPACES-}`)

Or `set -euo pipefail`

# Other

- `set -x`: Print each command
