bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# Make my custom abbreviations expanstion clear autosuggestions
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=magic-abbrev-expand-and-accept

# fzf
# Make `fzf` bindings available, since this is being manually imported here
# `fzf` should be installed at `~/.fzf/`, using the command 
# `~/.fzf/install --bin`, which avoids installing the completions automatically
FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
source ~/.fzf/shell/completion.zsh
source ~/.fzf/shell/key-bindings.zsh
