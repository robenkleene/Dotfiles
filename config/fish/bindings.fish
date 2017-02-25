function delete-current-history-search
  if commandline --search-mode
    echo -e "\n"
    history --delete (commandline)
    commandline -f history-search-backward
  end
end

function edit_cmd --description 'Input command in external editor'
  set tempfile (mktemp /tmp/fish.cmd.XXXXXXXX)
  and test -n "$tempfile"
  and set cursorposition (commandline -C)
  and commandline -b > $tempfile
  and vim-edit -c 'set ft=fish' $tempfile
  and set edited (cat $tempfile)
  and test -n "$edited"
  and commandline -r $edited
  and commandline -C $cursorposition
  and command rm $tempfile
end

# Make `fzf` bindings available, since this is being manually imported here
# `fzf` should be installed at `~/.fzf/`, using the command 
# `~/.fzf/install --bin`, which avoids installing the completions automatically
source ~/.fzf/shell/key-bindings.fish

function fish_user_key_bindings
  # Better binding but I can't get this to work
  bind \cx\ce 'edit_cmd'
  # bind \ee 'edit_cmd'
  bind \eD delete-current-history-search
  bind \ct fzf-file-widget
  bind \cr fzf-history-widget
  bind \ec fzf-cd-widget
end
