declare -a tools

# Each entry is a package name, or `<name> <source>` to install the package
# from somewhere other than PyPI, such as a git URL.
tools=(
'progic git+https://github.com/robenkleene/progic.git'
)
if [[ "$(uname)" = "Linux" ]]; then
  tools+=('qmk')
fi

declare -a tool_names
for entry in "${tools[@]}"; do
  tool_names+=("${entry%% *}")
done

# Lists the names of the installed tools
installed_tools() {
  # `uv tool list` prints a `<name> v<version>` line per tool, followed by a
  # `- <executable>` line per executable, and prints "No tools installed" to
  # stderr when there aren't any
  uv tool list 2>/dev/null | grep -v '^- ' | cut -d ' ' -f 1 || true
}

# Prints the key (e.g., `cpython-<version>-<os>-<arch>-<libc>`) of the newest
# stable Python uv can install, which is what uv installs by default when it
# has no Python yet
latest_python() {
  # `uv python list` prints newest first, the pattern skips pre-releases (e.g.,
  # `3.16.0a1`) and other variants (e.g., `+freethreaded`)
  uv python list | grep -E '^cpython-[0-9]+\.[0-9]+\.[0-9]+-' | head -n 1 | cut -d ' ' -f 1
}

# Lists the keys of the Python versions uv has installed itself
installed_pythons() {
  uv python list --only-installed | grep -F "$(uv python dir)/" | cut -d " " -f 1 | sort -u || true
}
