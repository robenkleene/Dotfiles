function _robenkleene_delete_current_history_search
  if commandline --search-mode
    echo -e "\n"
    history --delete (commandline)
    commandline -f history-search-backward
  end
end

function _robenkleeen_edit_command --description 'Input command in external editor'
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
fzf_key_bindings
# The `$dir` directory allows subdirectory expansion, e.g., 
# `vim Swift/<CTRL-T>`
set FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND \$dir"

function fish_user_key_bindings
  # Better binding but I can't get this to work
  bind \cx\ce '_robenkleeen_edit_command'
  # bind \ee '_robenkleeen_edit_command'
  bind \eD _robenkleene_delete_current_history_search
  bind \ct fzf-file-widget
  bind \cr fzf-history-widget
  bind \ec fzf-cd-widget
end
