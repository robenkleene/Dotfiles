function vim-edit
  # Vim
  # vim $argv
  # NeoVim
  if test -n "$NVIM_LISTEN_ADDRESS"
    nvimedit $argv
  else
    nvim $argv
  end
end

# Emacs
function emacs-edit
  # Emacs
  # emacs $argv
  # Emacsclient
  emacsclient -t $argv
end
function magit
 emacs-edit -eval "(robenkleene/magit-status-startup)"
end
