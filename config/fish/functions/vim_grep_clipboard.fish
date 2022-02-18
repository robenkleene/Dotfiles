function vim_grep_clipboard
    safepaste | vim_grep
    commandline -f repaint
end
