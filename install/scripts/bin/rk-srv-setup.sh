#!/usr/bin/env bash

set -euo pipefail

# Files and directories to sync
# Patterns:
#   /**      - recursive directory copy
#   **.ext   - recursive glob (matches in subdirs)
#   *.ext    - non-recursive glob (matches in dir only)
DOTFILES=(
    ".bin/nobin/_rk-tmux-safecopy.sh"
    ".bin/nobin/_rk-tmux-set-ssh-status.sh"
    ".bin/rk-lorem"
    ".bin/rk-path-abs"
    ".bin/rk-today"
    ".bin/rk-tmux-srv-qui"
    ".bin/rk-tmux-srv-res"
    ".bin/rk-tmux-srv-sav"
    ".claude-local/**"
    ".claude/CLAUDE.md"
    ".claude/commands/*.md"
    ".claude/settings.json"
    ".config/Code/User/snippets/*.json"
    ".config/nvim/init.lua"
    ".config/tmux/*.conf"
    ".ctags"
    ".editorconfig"
    ".gitconfig"
    ".gitignore"
    ".hgignore"
    ".hgrc"
    ".hgrc-global"
    ".hushlogin"
    ".ignore"
    ".inputrc"
    ".local_alias"
    ".man-local/**"
    ".man/**"
    ".ripgreprc"
    ".tigrc"
    ".vim/*.vim"
    ".vim/after/**.vim"
    ".vim/autoload/plug.vim"
    ".vim/ftplugin/*.vim"
    ".vim/plugged/**.vim"
    ".vim/plugin/**.vim"
    ".vim/spell/en.utf-8.add"
    ".vimrc"
    ".vimrc_local.vim"
    ".zsh/**.zsh"
    ".zshenv"
    ".zshrc"
    ".zshrc_local.zsh"
)

usage() {
    echo "Usage: $(basename "$0") -H <hostname> [-f] [-v]"
    echo ""
    echo "Options:"
    echo "  -H <hostname>  Hostname (required)"
    echo "  -d             Dry run"
    echo "  -v             Verbose"
    echo "  -h             Help"
}

hostname=""
dry=false
verbose=false

while getopts "H:fvh" option; do
  case "$option" in
    H)
      hostname="$OPTARG"
      ;;
    d)
      dry=true
      ;;
    v)
      verbose=true
      ;;
    h)
      usage
      exit 0
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

if [[ -z "$hostname" ]]; then
  usage
  exit 1
fi

# Build list of paths to sync
paths_to_sync=()

for item in "${DOTFILES[@]}"; do
    if [[ "$item" == *"/**" ]]; then
        # Recursive directory copy
        dir="${item%/**}"
        src_dir="$HOME/$dir"
        if [[ -d "$src_dir" ]]; then
            paths_to_sync+=("./$dir")
        else
            echo "Warning path not found: $src_dir"
        fi
    elif [[ "$item" == *"**"* && "$item" != *"/**" ]]; then
        # Recursive glob pattern (e.g., .vim/after/**.vim)
        dir="${item%%\*\**}"
        dir="${dir%/}"
        ext="${item##*\*\*.}"
        pattern="*.$ext"
        src_dir="$HOME/$dir"
        if [[ -d "$src_dir" ]]; then
            while IFS= read -r -d '' file; do
                rel_path="${file#$HOME/}"
                paths_to_sync+=("./$rel_path")
            done < <(find -L "$src_dir" -type f -name "$pattern" -print0 2>/dev/null)
        else
            echo "Warning path not found: $src_dir"
        fi
    elif [[ "$item" == *"*."* ]]; then
        # Non-recursive glob pattern (e.g., *.vim)
        dir="${item%/*}"
        pattern="${item##*/}"
        src_dir="$HOME/$dir"
        if [[ -d "$src_dir" ]]; then
            shopt -s nullglob
            for file in "$src_dir"/$pattern; do
                if [[ -f "$file" ]]; then
                    rel_path="${file#$HOME/}"
                    paths_to_sync+=("./$rel_path")
                fi
            done
            shopt -u nullglob
        else
            echo "Warning path not found: $src_dir"
        fi
    elif [[ -f "$HOME/$item" ]]; then
        paths_to_sync+=("./$item")
    elif [[ -d "$HOME/$item" ]]; then
        paths_to_sync+=("./$item")
    else
        echo "Warning path not found: $HOME/$item"
    fi
done

if [[ ${#paths_to_sync[@]} -eq 0 ]]; then
    echo "No files to sync"
    exit 0
fi

cd "$HOME"

rsync_flags="-avRL"
if [[ "$verbose" = true ]]; then
    rsync_flags="-avvRL --itemize-changes"
fi

# Ignore `[[ $? -eq 23 ]]` which happens with too many duplicate filenames,
# which happens because the `-R` flag implicitly addes the parent directory
if [[ "$dry" = false ]]; then
    rsync $rsync_flags "${paths_to_sync[@]}" "$hostname:~/" || [[ $? -eq 23 ]]
else
    echo "Dry run"
    rsync $rsync_flags --dry-run "${paths_to_sync[@]}" "$hostname:~/" || [[ $? -eq 23 ]]
fi
