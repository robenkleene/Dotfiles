bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# Make my custom abbreviations expanstion clear autosuggestions
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=magic-abbrev-expand-and-accept
