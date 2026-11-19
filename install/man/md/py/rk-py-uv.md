- `uv python list`: List available and installed Python versions
- `uv python list --only-installed`: List installed Python versions
- `uv python install <version>`: Install a Python version (e.g., `uv python install 3.14`)
- `uv python dir`: Print the directory uv installs Python versions to

# Tools

Install command-line programs written in Python with `uv tool`, which gives each one its own environment (similar to `pipx`).

- `uv tool install <name>`: Install a tool from PyPI
- `uv tool install git+<url>`: Install a tool from a git repository
- `uv tool list`: List installed tools and their executables
- `uv tool upgrade <name>`: Upgrade a tool
- `uv tool upgrade --all`: Upgrade all tools (also picks up new commits for tools installed from git)
- `uv tool uninstall <name>`: Uninstall a tool
- `uv tool uninstall --all`: Uninstall all tools
- `uvx <name>`: Run a tool without installing it (short for `uv tool run`)

# `bin`

To print the directory tool executables are installed to (`~/.local/bin` by default):

    uv tool dir --bin

`uv tool update-shell` adds that directory to the `PATH` in the shell startup files.

# Notes

- uv downloads the Python version a tool needs when no matching version is installed, so it doesn't need `pyenv` or a Homebrew Python.
- Don't use `pip install --user` with a Homebrew Python, it refuses with an `externally-managed-environment` error (PEP 668).
