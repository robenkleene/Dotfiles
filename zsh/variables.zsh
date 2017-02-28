if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  VIM_COMMAND=nvimedit
else
  VIM_COMMAND=nvim
fi
EMACS_COMMAND='emacsclient -t'
ACK_COMMAND=rg
