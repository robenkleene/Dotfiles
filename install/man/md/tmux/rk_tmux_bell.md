`tmux` shows a `!` next to a window in the current session if a pane in that window triggers a bell.

Do `sleep 5; printf '\a'` in a pane to test a bell.

Note that `tmux` does not notify for bells in other sessions, and the terminal client also won't get notifications of bells in other sessions.
