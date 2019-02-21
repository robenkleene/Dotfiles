# grep
alias -g G='| grep'
alias -g C='| column'
alias -g L='| less'
alias -g A='| rg --no-line-number --no-filename'
alias -g Y='| safecopy'
alias -g Y1='| safecopy1'
alias -g B='| bbresults --pattern grep --new-window'
# Disable these, there's something very strange about how global aliases call
# interactive commads. Starting `vim` results it in having to start twice,
# which is very slow.
# alias -g V="| $VIM_COMMAND -"
# alias -g Q='| vim_grep'
alias -g V="$VIM_COMMAND -"
alias -g Q='vim_grep'
alias -g F='fzf_vim_grep'
alias -g FF='fzf_vim_file'
alias -g 0VA="| xargs -o -0 $VIM_COMMAND"
alias -g VA="| xargs -o $VIM_COMMAND"
alias -g O='2>&1'
if [[ "$(uname)" = "Darwin" ]]; then
  alias -g OR="| xargs open -R"
fi

# Basic
alias -- -='cd -'
alias ..='cd ..'

if [[ "$(uname)" = "Linux" ]]; then
  alias ls='ls --color=auto'
else
  alias ls='gls --color=auto'
fi

alias p='safepaste'
alias y='safecopy'
alias safecopy1='tr -d '\''\n'\'' | tee /dev/tty | safecopy'
alias shs='ssh_start'
alias sts='ssh_tmux_start'
alias strs='ssh_tmux_restore_start'

# Override

# rg
# mitmproxy
# Supposedly these can be set in a `~/.mitmproxy/config.yaml`, it wasn't
# working with:
# palette_transparent: true
# no_mouse: true
alias mitmproxy='mitmproxy --no-mouse --palette-transparent'

# Shortcut

# `zsh`
alias zoi='zsh_edit_config'
# alias ol="$EDITOR settings.sh"
# alias sl="source settings.sh"
# alias ob="$EDITOR build.log"
# alias ot="$EDITOR test.log"
# alias dh='dirs -v'

# scripts
alias n='terminal_new'
alias o='open_custom'

# `tmux`
alias tma='tmux attach'
alias tmnd='tmux_name_directory'
alias tmsr='tmux_session_auto_restore'
alias tmsq='tmux_session_auto_save_quit'
alias tmp='tmux_paths'
alias tmpa='tmux_paths -a'
alias tmc='tmux_paths_run'
alias tmack='tmux_paths_rg'
alias tmfe='fzf_tmux_vim_file'
alias tmfw='fzf_tmux_window'
alias tmgs='tmux_git_status'
alias tmssdw='tmux_session_save_dropbox_work'
alias tmba='tmux_banner_all'

# `safari`
alias sfhs='fzf_safari_history_open'

# `make`
alias mt='make test'
alias ml='make lint'
alias mac='make autocorrect'

# `emacs`
# alias magit="emacs -eval \"(robenkleene/magit-status-startup)\""
# alias magit-log="emacs -eval \"(robenkleene/magit-log)\""
alias mgs='emacs_magit_status'
alias mgl='emacs_magit_log'
alias e="$EMACS_COMMAND"

# `vim_cd`
alias d='vim_cd'

# `vim`
alias vcd='vim_cd_file'
alias vtd='vim_todo'
alias vgd='vim_git_diff'
alias vdg='vim_diff_grep'
alias vgm='vim_git_modified'
alias vgc='vim_git_conflicts'
alias vse='vim_server_edit'
alias vsr='vim_session_restore_auto'
alias vsra='vim_session_restore_auto'
alias vsrs='vim_session_restore_saved'

# `emacs`
if [[ "$(uname)" = "Darwin" ]]; then
  alias gemacs="open -a emacs"
fi

# Xcode
if [[ "$(uname)" = "Darwin" ]]; then
  alias xcb='xcodebuild_debug'
  alias ox='fzf_project_xcode'
fi

# `cd`
alias cdtd='cd_todo'

# `doc` & `snp`
alias snp='fzf_snippet_copy'
alias snpe='fzf_snippet_editor'
alias doce='fzf_documentation_editor'

# `git`
alias gbp='git_branch_print'
alias gblpr='git_branch_list_pruned'
alias grv='git_revision_print'
alias grvp='git_revision_print'
alias grt='git_remote_print'
alias grtp='git_remote_print'
alias grtao='git_remote_add_origin'
alias gcd='git_cd_root'
alias gdg='git_diff_grep'
alias gbpr='git_branch_prune'
alias gprpr='git_process_pull_request'
alias gpbo='git_push_branch_origin'

# `jekyll`
alias jsw='jekyll_serve_watch'
alias jswd='jekyll_serve_watch_drafts'
alias jw='jekyll_write'

# `slug`
alias slpr='slug_project'
alias slpre='slug_project_edit'

# Edit
alias er='eval $EDITOR README.md'
alias ec="safepaste | $VIM_COMMAND -"
