# Startup

# tmux
# Fix for `tmux` overwriting this binding in `tmux.conf` with `send-prefix`
# This is only necessary if using `C-\` as prefix
# if [ ! -z "$TMUX" ]; then
#   tmux bind-key 'C-\' select-pane -t :.+
# fi
# Echo running sessions if there are any
if tmux ls >/dev/null 2>/dev/null; then
  # Only echo if we aren't already in a tmux session
  if [ -z "$TMUX" ]; then
    if pgrep -f -q '[Ee]macs.*--bg-daemon'; then
      echo "Emacs server is running"
    fi

    if pgrep -q mysqld; then
      echo "MySQL is running"
    fi

    echo tmux sessions
    tmux ls
  fi
fi
