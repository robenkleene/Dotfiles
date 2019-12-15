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
    # These `ps` searches are slow, so don't them when restorying `tmux`
    # sessions.
    # TODO: These should be combined into one search.
    # Emacs
    # Display a greeting message if the server is running
    if ps -u $USER | grep '[Ee]macs.*--bg-daemon' | grep --silent -v grep; then
      echo "Emacs server is running"
    fi

    if ps -u $USER | grep 'mysqld' | grep --silent -v grep; then
      echo "MySQL is running"
    fi

    echo tmux sessions
    tmux ls
  fi
fi
