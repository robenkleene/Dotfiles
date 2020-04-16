# grep
alias -g G='| grep'
alias -g C='| column'
alias -g L='| less'
alias -g A='| rg --no-line-number --no-filename'
alias -g Y='| safecopy'
alias -g Y1='| safecopy1'
# Don't include the pipe, if it means opening in another application
# Disable these, there's something very strange about how global aliases call
# interactive commads. Starting `vim` results it in having to start twice,
# which is very slow.
# alias -g V="| $VIM_COMMAND -"
# alias -g Q='| vim_grep'
alias -g V="$VIM_COMMAND -"
alias -g Q='vim_grep'
alias -g F='fzf_vim_grep'
alias -g FF='fzf_vim_file'
alias -g 0VA="xargs -o -0 $VIM_COMMAND"
alias -g VA="xargs -o $VIM_COMMAND"
if [[ "$(uname)" = "Darwin" ]]; then
  alias -g OR="| xargs open -R"
  alias -g B='bbresults --pattern grep --new-window'
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
alias pv="safepaste | $VIM_COMMAND -"
alias safecopy1='tr -d '\''\n'\'' | tee /dev/tty | safecopy'
alias shs='ssh_start'
alias sts='ssh_tmux_start'
alias strs='ssh_tmux_restore_start'
alias ge='emacs_app'
alias gemacs='emacs_app'

# Override

# fd
# Display hidden files by default
# This doesn't work now because the `fzf` commands also add
# hidden, we should be able to add the `--hidden` flag twice in a
# future version of `fd` and we can uncomment this then.
# alias fd='fd --hidden'

# `zsh`
alias zoi='zsh_edit_config'
# alias ol="$EDITOR settings.sh"
# alias sl="source settings.sh"
# alias ob="$EDITOR build.log"
# alias ot="$EDITOR test.log"
# alias dh='dirs -v'

# scripts
alias t='terminal_cd'
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
alias tmn='tmux_shell_new'

# `safari`
alias sfhs='fzf_safari_history_open'

# `make`
alias mt='make test'
alias ml='make lint'
alias mac='make autocorrect'
alias macc='make autocorrect && git add -A :/ && git commit -m "Run autocorrect"'

# `emacs`
alias mgs='emacs_magit_status'
alias mgl='emacs_magit_log'
alias f="$EMACS_COMMAND ."

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

# Test Variable
alias ptv='echo $test_variable'
# The `|| true` prevents an exit status of 1 if the output does not end in a
# new line
alias ytv='yank_test_variable'
alias ctv='safepaste | read test_variable || true'

# `git`
alias gbp='git_branch_print'
alias gblpr='git_branch_list_pruned'
alias grv='git_revision_print'
alias grvp='git_revision_print'
alias grt='git_remote_print'
alias grtp='git_remote_print'
alias grtao='git_remote_add_origin'
alias gac='git_commit_all'
alias gacm='git_commit_all'
alias cdg='git_cd_root'
alias gdg='git_diff_grep'
alias gbpr='git_branch_prune'
alias gprpr='git_process_pull_request'
alias gpbo='git_push_branch_origin'
alias scw='source_control_open_site'
alias scwp='source_control_open_site -p'
alias sgpt='sgitt -cp'
alias sglt='sgitt -l'
alias sgla='git_pull_all'
alias gcu='git_commit_update'

# `jekyll`
alias jsw='jekyll_serve_watch'
alias jswd='jekyll_serve_watch_drafts'
alias jw='jekyll_write'
# Blog
alias bgpd='blog_git_publish_drafts'

# `slug`
alias slpr='slug_project'
alias slpre='slug_project_edit'

# Edit
alias erm='eval $EDITOR README.md'
alias ecrm='eval $EMACS_COMMAND README.md'

# Tags
alias tags="generate_tags"

# Common
alias journal="journal_new_make_default_edit"
alias tweet="markdown_tweet_edit"
alias writing="$VIM_COMMAND ~/Text/writing/README.md"
alias backup="backup_file"
