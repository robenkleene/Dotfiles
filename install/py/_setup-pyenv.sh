# Sourced by the install scripts to put the `pyenv` Python first on `PATH`, so
# `python3` and `pip3` never resolve to a system or Homebrew Python (which
# refuse `pip install --user` under PEP 668)

# The minor version to use, the latest patch release of it gets installed
python_version="3.14"

export PYENV_ROOT="$HOME/.pyenv"

if [[ ! -e "$PYENV_ROOT" ]]; then
  echo "$PYENV_ROOT doesn't exist, run install/py/install.sh first" >&2
  exit 1
fi

command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# `eval` instead of `source <(...)` because `source` of a process substitution
# silently does nothing in Bash 3.2 (the macOS `/bin/bash`)
eval "$(pyenv init -)"
