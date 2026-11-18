declare -a modules

# Each entry is a package name, or `<name> <source>` to install the package
# from somewhere other than PyPI, such as a git URL.
modules=(
'pipdeptree'
'pip-autoremove'
'progic git+https://github.com/robenkleene/progic.git'
)
if [[ "$(uname)" = "Linux" ]]; then
  modules+=('qmk')
fi

declare -a module_names
for entry in "${modules[@]}"; do
  module_names+=("${entry%% *}")
done
