if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  VIM_COMMAND=nvimedit
else
  VIM_COMMAND=nvim
fi
ACK_COMMAND=rg
