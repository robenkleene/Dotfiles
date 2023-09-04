#!/usr/bin/env bash

set -euo pipefail

# `git` aliases (in `gitconfig`) area always run from the `git` root, and `GIT_PREFIX` contains the path the alias was run from
if [[ -d "${GIT_PREFIX:-}" ]]; then
  cd "${GIT_PREFIX:-}"
fi

git -c color.status=always status --short | \
  fzf --nth 2.. --no-sort --ansi --reverse --multi \
  --preview "~/.bin/nobin/_f_a_git_file_diff.sh {}" \
  --bind="ctrl-e:become(${EDITOR:-vim} {+2..}),ctrl-t:become(git difftool {+2..}),alt-p:become(~/.bin/nobin/_f_a_git_file_diff.sh {+}),alt-s:become(~/.bin/nobin/_f_a_git_file_stage_toggle.sh {+}),ctrl-u:preview-page-up,ctrl-d:preview-page-down,ctrl-a:toggle-all" \
  --height=100% --preview-window=right,50%:wrap
