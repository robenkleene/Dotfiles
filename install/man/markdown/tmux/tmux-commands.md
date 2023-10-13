# `tmux`

* `tmux kill-server`: Kill everything
* `:source-file ~/.tmux.conf`: Reload `tmux.conf`
* `tmux source-file ~/.tmux.conf`: Reload `tmux.conf`
* `tmux list-keys -t vi-edit`

## Sessions

* `<prefix>$`: Rename session
* `<prefix>d`: Detach
* `tmux ls`: List sessions from terminal
* `tmux attach`: Attach if there is only one session
* `tmux attach -t [target session]`: Attach to a specific session
* `tmux kill-session`: Kill current session

### Creating Sessions

* `:new`: Make new session

### Switching Sessions

* `<prefix>s`: Choose session
* `<prefix>(` / `<prefix>)` : Next / Previous session

## Panes

* `<prefix>x`: Kill pane
* `<prefix>M-Up` / `<prefix>M-Down` / `<prefix>M-Left` / `<prefix>M-Right`: Resize pane
* `respawn-pane -k`: Restart current shell
* `break-pane -t :`: Break pane out to new window
* `join-pane -t :0`: Move pane to window 0
* `respawn-pane -k`: Re-spawn pane, killing first (use on "stuck" panes)

### Creating Panes

* `<prefix>%`: Vertical Split
* `<prefix>"`: Horizontal Split

### Switching Panes

* `<prefix>o`: Next pane
* `<prefix>;`: Previous pane
* `<prefix>q`: Switch to numbered pane
* `<prefix>!`: Switch a pane to window

### Moving Panes

* `<prefix>{` / `<prefix>{`: Move panes

## Windows

* `<prefix>,`: Rename Window
* `<prefix>&`: Kill window

### Creating Windows

* `<prefix>c`: New Window
* `new-window -a`: New window to the right of this one

### Switching Windows

* `<prefix>0`, `<prefix>1`...: Switch to that window number
* `<prefix>'`: Switch to window (Prompt to enter window number)
* `<prefix>l`: Last Window
* `<prefix>n` / `<prefix>p`: Next Window

### Moving Windows

* `swap-window -s 3 -t 1`: Move window index 3 to a used index
* `swap-window -t 1`: Move current window to a used index
* `:movew`: Move window to next unused window number
	* `:movew -r`: Move all windows to next unused window number
* `<prefix>.`: Move window (Prompt to enter window number)

## Scroll, Copy & Paste Modes

* `<prefix>[`: Enter copy/scroll mode
* `<prefix>]`: Paste
* `q`: Quit scroll mode
* `<prefix>Page Up`: Enter copy mode and page up one screen
