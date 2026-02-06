#!/usr/bin/env bash

set -euo pipefail

# Files and directories to sync
# Patterns:
#   /**      - recursive directory copy
#   **.ext   - recursive glob (matches in subdirs)
#   *.ext    - non-recursive glob (matches in dir only)
DOTFILES=(
    ".bin/nobin/_safecopy.sh"
    ".bin/nobin/_safepaste.sh"
    ".bin/path_abs"
    ".bin/rk_copy"
    ".bin/rk_lorem"
    ".bin/rk_paste"
    ".bin/rk_today"
    ".claude-local/**"
    ".claude/CLAUDE.md"
    ".claude/commands/**"
    ".claude/settings.json"
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
    echo "Usage: $(basename "$0") -h <hostname> [-f]"
    echo "Syncs dotfiles to a host"
    echo ""
    echo "Options:"
    echo "  -h <hostname>  Target hostname (required)"
    echo "  -f             Force sync (default is dry-run)"
    exit 1
}

hostname=""
force=false

while getopts "h:f" opt; do
    case $opt in
        h) hostname="$OPTARG" ;;
        f) force=true ;;
        *) usage ;;
    esac
done

if [[ -z "$hostname" ]]; then
    usage
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
        fi
    elif [[ -f "$HOME/$item" ]]; then
        paths_to_sync+=("./$item")
    elif [[ -d "$HOME/$item" ]]; then
        paths_to_sync+=("./$item")
    fi
done

if [[ ${#paths_to_sync[@]} -eq 0 ]]; then
    echo "No files to sync"
    exit 0
fi

cd "$HOME"

if [[ "$force" == true ]]; then
    rsync -avRL "${paths_to_sync[@]}" "$hostname:~/"
    echo "Done syncing dotfiles to $hostname"
else
    echo "Dry-run mode (use -f to sync):"
    rsync -avRL --dry-run "${paths_to_sync[@]}" "$hostname:~/"
fi
