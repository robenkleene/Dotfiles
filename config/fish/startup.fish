# Startup

# Emacs
# Test if server is running
function is-emacs-server-running
  ps -u $USER | grep 'emacs --daemon' | grep --silent -v grep
end
# Display a greeting message if the server is running
if is-emacs-server-running
  echo Emacs server is running
else
end

# tmux
# Echo running sessions if there are any
if tmux ls >/dev/null 2>/dev/null
  # Only echo if we aren't already in a tmux session
  if test -z "$TMUX"
    echo tmux sessions
    tmux ls
  end
end
