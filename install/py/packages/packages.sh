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

# `UV_MANAGED_PYTHON` makes `uv` run the tools with a Python it downloads
# itself, never a system or Homebrew Python whose upgrades would break them
export UV_MANAGED_PYTHON=1

# Lists the names of the installed tools
installed_tools() {
  # `uv tool list` prints a `<name> v<version>` line per tool, followed by a
  # `- <executable>` line per executable, and prints "No tools installed" to
  # stderr when there aren't any
  uv tool list 2>/dev/null | grep -v '^- ' | cut -d ' ' -f 1 || true
}
