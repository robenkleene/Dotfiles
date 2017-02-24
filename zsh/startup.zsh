# Startup

# Emacs
# Display a greeting message if the server is running
if ps -u $USER | grep 'emacs --daemon' | grep --silent -v grep; then
  echo Emacs server is running
fi

# tmux
# Echo running sessions if there are any
if tmux ls >/dev/null 2>/dev/null; then
  # Only echo if we aren't already in a tmux session
  if [ -z "$TMUX" ]; then
    echo tmux sessions
    tmux ls
  fi
fi
