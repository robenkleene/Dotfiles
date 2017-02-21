function delete-current-history-search
  if commandline --search-mode
    echo -e "\n"
    history --delete (commandline)
    commandline -f history-search-backward
  end
end

function fish_user_key_bindings
  # Better binding but I can't get this to work
  # bind \cx\ce 'edit_cmd'
  bind \ee 'edit_cmd'
  bind \eD delete-current-history-search
end
