# These could use the pipe, but in rare cases they cause problems so they've
# been removed.
# For example, doing something like:
# cat Template.html Y
# p | pandoc -f html -t markdown Y
# Will end up with an empty clipboard, but the following works fine:
# cat Template.html |Y
# p | pandoc -f html -t markdown |Y
# For that reason, we've removed the pipe from all aliases for consistency
# (even though it still works fine with some).
# Example command with the pipe:
# alias -g Y='| safecopy'
# alias -g G='grep'
# alias -g C='column'
# alias -g L='less'
# alias -g A='rg --no-line-number --no-filename'
# alias -g Y='safecopy'
# alias -g Y1='safecopy1'
# These should never use the pipe, for some reason starting an interactive
# command with the pipe behaves unpredictably. In particular, starting `vim`
# seems to need to open it twice, which is slow.
# Example commands with the pipe:
# alias -g V="| $VIM_COMMAND -"
# alias -g Q='| vim_grep'
# alias -g V="$VIM_COMMAND -c \"ScratchBuffer\" -"
# alias -g Q='vim_grep'
# alias -g F='fzf_vim_grep'
# alias -g 0VA="xargs -o -0 $VIM_COMMAND"
# alias -g VA="xargs -o $VIM_COMMAND"
# if [[ "$(uname)" = "Darwin" ]]; then
#   alias -g OR="| xargs open -R"
#   alias -g B='bbresults --pattern grep --new-window'
# fi

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
alias stsr='ssh_tmux_restore_start'
alias ge='emacs_app'
alias gemacs='emacs_app'
alias excel='open -a "Microsoft Excel"'
alias f='fish'

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
alias rg='rg_custom'
alias q='vim_grep'
alias l='less'
alias s='ssh_start && { egit -p || egitn } && echo "Auto" && sgitt -cp'
alias u='ssh_git_pull_all'
alias ut='ssh_git_pull_all -t'

# `tmux`
alias tma='tmux attach'
alias tmnd='tmux_name_directory'
alias tmsr='tmux_session_auto_restore_ssh'
alias tmsq='tmux_session_auto_save_quit'
alias tmp='tmux_paths'
alias tmpa='tmux_paths -a'
alias tmc='tmux_paths_run'
alias tmack='tmux_paths_rg'
alias tmgs='tmux_git_status'
alias tmssdw='tmux_session_save_dropbox_work'
alias tmba='tmux_banner_all'
alias tmn='tmux_shell_new'

# `make`
alias mt='make test'
alias ml='make lint'
alias mac='make autocorrect'
alias macc='make autocorrect && git add -A :/ && git commit -m "Run autocorrect"'

# `node`
alias nt='npm test'
alias nrt='npm run test'
alias nrl='npm run lint'
alias nrf='npm run format'
alias nrac='npm run autocorrect'

# `emacs`
alias mgs='emacs_magit_status'
alias mgl='emacs_magit_log'

# `vim_cd`
alias d='vim_cd'

# `vim`
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

# `doc` / `snp` / `dev`
alias snp='fzf_snippet_copy'
alias snpe='fzf_snippet_edit'
alias doce='fzf_documentation_edit'
alias doc='fzf_documentation_less'
alias dev='fzf_developer'

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
alias gbpr='git_branch_prune'
alias gprpr='git_process_pull_request'
alias gpbo='git_push_branch_origin'
alias scw='source_control_open_site'
alias scwp='source_control_open_site -p'
alias scwm='BROWSER= gh pr view --web'
alias sgpt='sgitt -cp'
alias sgut='sgitt -u'
alias sgua='git_pull_all'
alias gcu='git_commit_update'
alias gua='git_pull_all'

# `slug`
alias slpr='slug_project'
alias slpre='slug_project_edit'

# Edit
alias erm='eval $EDITOR README.md'
alias ecrm='eval $EMACS_COMMAND README.md'

# Tags
alias tags="generate_tags"

# Common
alias journal="$VIM_COMMAND ~/Text/journal/README.md"
alias tweet="markdown_tweet_edit"
alias qa="quick_text_search"
alias writing="$VIM_COMMAND ~/Text/writing/README.md"
alias backup="backup_file"
alias vs="vscode"
