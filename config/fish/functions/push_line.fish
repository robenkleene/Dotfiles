function push_line
  commandline -f kill-whole-line
  function restore_line -e fish_postexec
    commandline -f yank
    functions -e restore_line
  end
end
